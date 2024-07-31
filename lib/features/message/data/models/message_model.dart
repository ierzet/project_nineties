import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.senderId,
    required super.senderName,
    required super.senderAvatarUrl,
    required super.content,
    required super.timestamp,
    required super.isMe,
    super.readBy,
  });

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: data['id'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      senderAvatarUrl: data['senderAvatarUrl'] ?? '',
      content: data['content'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
      isMe: data['isMe'] ?? false,
      readBy: Map<String, bool>.from(data['readBy'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatarUrl': senderAvatarUrl,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isMe': isMe,
      'readBy': readBy,
    };
  }

  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      senderId: entity.senderId,
      senderName: entity.senderName,
      senderAvatarUrl: entity.senderAvatarUrl,
      content: entity.content,
      timestamp: entity.timestamp,
      isMe: entity.isMe,
      readBy: entity.readBy,
    );
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      content: content,
      timestamp: timestamp,
      isMe: isMe,
      readBy: readBy,
    );
  }
}
