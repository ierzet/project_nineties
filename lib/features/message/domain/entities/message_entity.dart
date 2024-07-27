import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderAvatarUrl;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderAvatarUrl,
    required this.content,
    required this.timestamp,
    required this.isMe,
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
    );
  }
}

Stream<List<Message>> getMessages() {
  final messagesCollection = FirebaseFirestore.instance.collection('messages');
  return messagesCollection.orderBy('timestamp').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList();
  });
}

Future<void> addMessage(Message message) {
  final messagesCollection = FirebaseFirestore.instance.collection('messages');
  return messagesCollection.add(message.toMap());
}