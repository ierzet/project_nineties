import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';

class ChatGroupPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  ChatGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userAccount = context.read<AppBloc>().state.user.user;
    final senderAvatarUrl = userAccount.photo ?? '';
    final senderId = userAccount.id;
    final senderName = userAccount.name ?? '';
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.defaultPadding.w,
              vertical: AppPadding.halfPadding.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.onPrimaryContainer,
                child: Icon(Icons.chat_rounded,
                    color: theme.colorScheme.primaryContainer, size: 30),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<Message>>(
            stream: getMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final messages = snapshot.data!;
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
                    time:
                        '${message.timestamp.hour}:${message.timestamp.minute}',
                    senderName: message.senderName,
                    senderAvatarUrl: message.senderAvatarUrl,
                  );
                },
              );
            },
          ),
        ),
        const Divider(height: 1),
        Container(
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
                    // When done button is pressed, remove focus to close the keyboard
                    _focusNode.unfocus();
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final value = _controller.text.trim();
                  if (value.isNotEmpty) {
                    final message = Message(
                      id: '', // Firestore will auto-generate the ID
                      senderId: senderId,
                      senderName: senderName,
                      senderAvatarUrl: senderAvatarUrl,
                      content: value,
                      timestamp: DateTime.now(),
                      isMe: true,
                    );
                    await addMessage(message);
                    _controller.clear();
                    _scrollToBottom();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}

class ChatMessage extends StatelessWidget {
  final bool isMe;
  final String message;
  final String time;
  final String senderName;
  final String senderAvatarUrl;

  const ChatMessage({
    super.key,
    required this.isMe,
    required this.message,
    required this.time,
    required this.senderName,
    required this.senderAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor = isMe
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor =
        isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant;
    final timeColor = isMe
        ? theme.colorScheme.onPrimary.withOpacity(0.7)
        : theme.colorScheme.onSurfaceVariant.withOpacity(0.7);
    final nameColor =
        isMe ? theme.colorScheme.onPrimary : theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CircleAvatar(
                  backgroundImage: NetworkImage(senderAvatarUrl),
                  onBackgroundImageError: (_, __) {
                    // Handle error, perhaps set a placeholder image
                  },
                  child: senderAvatarUrl.isEmpty
                      ? Icon(Icons.person,
                          color: theme.colorScheme.onSurfaceVariant)
                      : null,
                ),
              if (!isMe) const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        color: bubbleColor,
                        borderRadius: isMe
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              )
                            : const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            senderName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: nameColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            message,
                            style: TextStyle(
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            time,
                            style: TextStyle(
                              color: timeColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isMe) const SizedBox(width: 8),
              if (isMe)
                CircleAvatar(
                  backgroundImage: NetworkImage(senderAvatarUrl),
                  onBackgroundImageError: (_, __) {
                    // Handle error, perhaps set a placeholder image
                  },
                  child: senderAvatarUrl.isEmpty
                      ? Icon(Icons.person,
                          color: theme.colorScheme.onSurfaceVariant)
                      : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
