import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/message/data/models/message_model.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:rxdart/rxdart.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc({required this.useCase}) : super(MessageInitial()) {
    on<MessageSent>(_onMessageSent,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MessageRead>(_onMessageRead,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<AllMessagesRead>(_onAllMessagesRead,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MessageSubscriptionSuccsess>(_onMessageSubscriptionSuccsess,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<MessageSubscriptionFailure>(_onMessageSubscriptionFailure,
        transformer: debounce(const Duration(milliseconds: 500)));

    _messageSubscription = useCase().listen((result) {
      result.fold(
        (failure) => add(MessageSubscriptionFailure(message: failure.message)),
        (data) => add(MessageSubscriptionSuccsess(params: data)),
      );
    });
  }
  late final StreamSubscription _messageSubscription;
  final MessageUseCase useCase;

  void _onMessageSubscriptionSuccsess(
      MessageSubscriptionSuccsess event, Emitter<MessageState> emit) async {
    emit(MessageLoadDataSuccess(data: event.params));
  }

  void _onMessageSubscriptionFailure(
      MessageSubscriptionFailure event, Emitter<MessageState> emit) async {
    emit(MessageLoadFailure(message: event.message));
  }

  // void _onMessageStarted(
  //     MessageStarted event, Emitter<MessageState> emit) async {
  //   emit(MessageLoadInProgress());
  // }

  void _onMessageSent(MessageSent event, Emitter<MessageState> emit) async {
    final result = await useCase.addMessage(event.message);
    result.fold(
      (failure) {
        emit(MessageLoadFailure(message: failure.message));
      },
      (data) {},
    );
  }

  void _onMessageRead(MessageRead event, Emitter<MessageState> emit) async {
    final result =
        await useCase.markMessageAsRead(event.messageId, event.userId);
    result.fold(
      (failure) {
        emit(MessageLoadFailure(message: failure.message));
      },
      (data) {},
    );
  }

  void _onAllMessagesRead(
      AllMessagesRead event, Emitter<MessageState> emit) async {
    final result = await useCase.markAllMessagesAsRead(event.userId);
    result.fold(
      (failure) {
        emit(MessageLoadFailure(message: failure.message));
      },
      (data) {},
    );
  }

  @override
  Future<void> close() {
    _messageSubscription.cancel();
    return super.close();
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}

class MessageUseCase {
  const MessageUseCase({required this.repository});
  final MessageRepository repository;

  Future<Either<Failure, String>> addMessage(MessageEntity message) async {
    return repository.addMessage(MessageModel.fromEntity(message));
  }

  Future<Either<Failure, String>> markMessageAsRead(
      String messageId, String userId) async {
    return repository.markMessageAsRead(messageId, userId);
  }

  Future<Either<Failure, String>> markAllMessagesAsRead(String userId) async {
    return repository.markAllMessagesAsRead(userId);
  }

  Stream<Either<Failure, List<MessageEntity>>> call() {
    return repository();
  }
}

abstract class MessageRepository {
  // Future<List<MessageEntity>> fetchMessages();
  Future<Either<Failure, String>> addMessage(MessageModel message);
  Stream<Either<Failure, List<MessageEntity>>> call();
  Future<Either<Failure, String>> markMessageAsRead(
      String messageId, String userId);
  Future<Either<Failure, String>> markAllMessagesAsRead(String userId);
}

class MessageRepositoryImpl implements MessageRepository {
  final MessaggeRemoteDataSource remoteDataSource;

  const MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<MessageEntity>>> call() {
    return remoteDataSource
        .getMessagesStream()
        .map<Either<Failure, List<MessageEntity>>>(
      (messsages) {
        return Right(messsages);
      },
    ).handleError((error) {
      return Left(ServerFailure(error.toString()));
    });
    //TODO:rapihin handler error nya
  }

  @override
  Future<Either<Failure, String>> addMessage(MessageModel message) async {
    final result = await remoteDataSource.addMessage(message);
    return Right(result);
  }

  @override
  Future<Either<Failure, String>> markMessageAsRead(
      String messageId, String userId) async {
    final result = await remoteDataSource.markMessageAsRead(messageId, userId);
    return Right(result);
  }

  @override
  Future<Either<Failure, String>> markAllMessagesAsRead(String userId) async {
    final result = await remoteDataSource.markAllMessagesAsRead(userId);
    return Right(result);
  }
}

abstract class MessaggeRemoteDataSource {
  Stream<List<MessageEntity>> getMessagesStream();
  Future<String> addMessage(MessageModel message);
  Future<String> markMessageAsRead(String messageId, String userId);
  Future<String> markAllMessagesAsRead(String userId);
}

class MessaggeRemoteDataSourceImpl implements MessaggeRemoteDataSource {
  MessaggeRemoteDataSourceImpl(this.instance);
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Stream<List<MessageEntity>> getMessagesStream() {
    return instance
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      try {
        final messages = snapshot.docs.map((doc) {
          return MessageModel.fromFirestore(doc).toEntity();
        }).toList();
        return messages;
      } catch (e) {
        // Handle and throw a custom exception or return an empty list
        throw ServerFailure(e.toString());
      }
    }).handleError((error) {
      // Additional error handling if necessary
      throw ServerFailure(error.toString());
    });
  }

  @override
  Future<String> addMessage(MessageModel message) async {
    try {
      await instance.collection('messages').add(message.toMap());
      return 'success';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<String> markMessageAsRead(String messageId, String userId) async {
    await instance.collection('messages').doc(messageId).update({
      'readBy.$userId': true,
    });
    return 'success';
  }

  @override
  Future<String> markAllMessagesAsRead(String userId) async {
    final snapshot = await instance.collection('messages').get();
    for (var doc in snapshot.docs) {
      final message = Message.fromFirestore(doc);
      if (message.readBy[userId] != true) {
        await instance.collection('messages').doc(doc.id).update({
          'readBy.$userId': true,
        });
      }
    }
    return 'success';
  }
}
