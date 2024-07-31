import 'package:dartz/dartz.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/message/data/models/message_model.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:project_nineties/features/message/domain/repositories/message_repository.dart';

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
