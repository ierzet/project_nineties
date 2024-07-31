import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:project_nineties/features/message/domain/usecases/message_usecase.dart';
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
