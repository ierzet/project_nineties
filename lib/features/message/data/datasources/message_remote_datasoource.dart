
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_nineties/core/error/failure.dart';
import 'package:project_nineties/features/message/data/models/message_model.dart';
import 'package:project_nineties/features/message/domain/entities/message_entity.dart';

abstract class MessaggeRemoteDataSource {
  Stream<List<MessageEntity>> getMessagesStream();
  Future<String> addMessage(MessageModel message);
  Future<String> markMessageAsRead(String messageId, String userId);
  Future<String> markAllMessagesAsRead(String userId);
}

class MessaggeRemoteDataSourceImpl implements MessaggeRemoteDataSource {
  MessaggeRemoteDataSourceImpl(this.instance);
  FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Stream<List<MessageEntity>> getMessagesStream() {
    return instance
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .map((snapshot) {
      try {
        final messages = snapshot.docs.map((doc) {
          return MessageModel.fromFirestore(doc).toEntity();
        }).toList();
        return messages;
      } catch (e) {
        // Handle and throw a custom exception or return an empty list
        throw ServerFailure(e.toString());
      }
    }).handleError((error) {
      // Additional error handling if necessary
      throw ServerFailure(error.toString());
    });
  }

  @override
  Future<String> addMessage(MessageModel message) async {
    try {
      await instance.collection('messages').add(message.toMap());
      return 'success';
    } on FirebaseException catch (e) {
      throw FireBaseCatchFailure.fromCode(e.code);
    } on SocketException {
      throw const ConnectionFailure('failed connect to the network');
    } catch (e) {
      if (e is FireBaseCatchFailure) {
        rethrow;
      } else {
        throw const FireBaseCatchFailure();
      }
    }
  }

  @override
  Future<String> markMessageAsRead(String messageId, String userId) async {
    await instance.collection('messages').doc(messageId).update({
      'readBy.$userId': true,
    });
    return 'success';
  }

  @override
  Future<String> markAllMessagesAsRead(String userId) async {
    final snapshot = await instance.collection('messages').get();
    for (var doc in snapshot.docs) {
      final message = Message.fromFirestore(doc);
      if (message.readBy[userId] != true) {
        await instance.collection('messages').doc(doc.id).update({
          'readBy.$userId': true,
        });
      }
    }
    return 'success';
  }
}
