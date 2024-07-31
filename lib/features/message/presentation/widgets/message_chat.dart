import 'package:flutter/material.dart';

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
              if (!isMe) _buildAvatar(theme),
              if (!isMe) const SizedBox(width: 8),
              Flexible(child: _buildMessageBubble(theme)),
              if (isMe) const SizedBox(width: 8),
              if (isMe) _buildAvatar(theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    return CircleAvatar(
      backgroundImage: NetworkImage(senderAvatarUrl),
      onBackgroundImageError: (_, __) {
        // Handle error, perhaps set a placeholder image
      },
      child: senderAvatarUrl.isEmpty
          ? Icon(Icons.person, color: theme.colorScheme.onSurfaceVariant)
          : null,
    );
  }

  Widget _buildMessageBubble(ThemeData theme) {
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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
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
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(color: timeColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
