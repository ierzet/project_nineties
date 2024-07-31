
import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/message/data/datasources/message_remote_datasoource.dart';
import 'package:project_nineties/features/message/data/models/message_model.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:project_nineties/features/message/domain/repositories/message_repository.dart';

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
