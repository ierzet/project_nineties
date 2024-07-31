import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';
import 'package:project_nineties/features/message/presentation/bloc/message_bloc.dart';
import 'package:project_nineties/features/message/presentation/widgets/message_chat.dart';

class MessagesPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userAccount = context.read<AppBloc>().state.user.user;
    final messageBloc = context.read<MessageBloc>();
    final senderAvatarUrl = userAccount.photo ?? '';
    final senderId = userAccount.id;
    final senderName = userAccount.name ?? '';
    final theme = Theme.of(context);

    messageBloc.add(AllMessagesRead(userId: senderId));

    return Column(
      children: [
        _buildHeader(theme),
        _buildMessageList(messageBloc, senderId),
        _buildInputArea(
            context, messageBloc, senderId, senderName, senderAvatarUrl),
      ],
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.defaultPadding.w,
        vertical: AppPadding.halfPadding.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: theme.colorScheme.onPrimaryContainer,
            child: Icon(
              Icons.chat_rounded,
              color: theme.colorScheme.primaryContainer,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(MessageBloc messageBloc, String senderId) {
    return Expanded(
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageLoadDataSuccess) {
            final messages = state.data;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
            return ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessage(
                  isMe: message.senderId == senderId,
                  message: message.content,
                  time: '${message.timestamp.hour}:${message.timestamp.minute}',
                  senderName: message.senderName,
                  senderAvatarUrl: message.senderAvatarUrl,
                );
              },
            );
          } else if (state is MessageLoadFailure) {
            return Center(
                child: Text('Failed to load messages: ${state.message}'));
          } else if (state is MessageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildInputArea(
    BuildContext context,
    MessageBloc messageBloc,
    String senderId,
    String senderName,
    String senderAvatarUrl,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.halfPadding.w),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.photo),
            onPressed: () {
              // Add your image picker logic here
            },
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type a message',
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                _focusNode.unfocus();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              final value = _controller.text.trim();
              if (value.isNotEmpty) {
                final message = MessageEntity(
                  id: '', // Firestore will auto-generate the ID
                  senderId: senderId,
                  senderName: senderName,
                  senderAvatarUrl: senderAvatarUrl,
                  content: value,
                  timestamp: DateTime.now(),
                  isMe: true,
                  readBy: {senderId: true}, // Mark as read for sender
                );
                messageBloc.add(MessageSent(message: message));
                _controller.clear();
                _scrollToBottom();
              }
            },
          ),
        ],
      ),
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }
}
