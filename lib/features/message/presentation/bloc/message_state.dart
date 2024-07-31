part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoadInProgress extends MessageState {}

class MessageLoadSuccess extends MessageState {
  const MessageLoadSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class MessageLoadDataSuccess extends MessageState {
  const MessageLoadDataSuccess({required this.data});

  final List<MessageEntity> data;

  @override
  List<Object> get props => [data];
}

class MessageLoadFailure extends MessageState {
  const MessageLoadFailure({required this.message});

  final String message;
  @override
  List<Object> get props => [message];
}
