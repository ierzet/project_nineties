import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/message/data/models/message_model.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';

abstract class MessageRepository {
  // Future<List<MessageEntity>> fetchMessages();
  Future<Either<Failure, String>> addMessage(MessageModel message);
  Stream<Either<Failure, List<MessageEntity>>> call();
  Future<Either<Failure, String>> markMessageAsRead(
      String messageId, String userId);
  Future<Either<Failure, String>> markAllMessagesAsRead(String userId);
}
