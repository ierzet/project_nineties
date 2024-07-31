part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageStarted extends MessageEvent {}

class MessageSent extends MessageEvent {
  const MessageSent({required this.message});
  final MessageEntity message;
  @override
  List<Object> get props => [message];
}

class MessageSubscriptionSuccsess extends MessageEvent {
  const MessageSubscriptionSuccsess({required this.params});

  final List<MessageEntity> params;
  @override
  List<Object> get props => [params];
}

class MessageSubscriptionFailure extends MessageEvent {
  const MessageSubscriptionFailure({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

class MessageRead extends MessageEvent {
  const MessageRead({required this.messageId, required this.userId});

  final String messageId;
  final String userId;
  @override
  List<Object> get props => [messageId, userId];
}

class AllMessagesRead extends MessageEvent {
  const AllMessagesRead({required this.userId});
  final String userId;
  @override
  List<Object> get props => [userId];
}
