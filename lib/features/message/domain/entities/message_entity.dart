import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatarUrl;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final Map<String, bool> readBy;
  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.content,
    required this.timestamp,
    required this.isMe,
    this.readBy = const {}, // Initialize with an empty map
  });
  static final empty = MessageEntity(
    id: '',
    senderId: '',
    senderName: '',
    senderAvatarUrl: '',
    content: '',
    timestamp: DateTime(1970, 1, 1), // A default timestamp value
    isMe: false,
    readBy: const {},
  );

  @override
  List<Object?> get props => [
        id,
        senderId,
        senderName,
        senderAvatarUrl,
        content,
        timestamp,
        isMe,
        readBy,
      ];
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatarUrl;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final Map<String, bool> readBy; // Add readBy field

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.content,
    required this.timestamp,
    required this.isMe,
    this.readBy = const {}, // Initialize with an empty map
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'senderName': senderName,
      'senderAvatarUrl': senderAvatarUrl,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isMe': isMe,
      'readBy': readBy, // Add to map
    };
  }

  factory Message.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Message(
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
}
