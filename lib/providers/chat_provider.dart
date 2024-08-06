import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:owl/models/message.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/services/database_service.dart';
import 'package:owl/utils/generate_id.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _subscription;

  bool _loading = true;
  bool get loading => _loading;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  String? _error;
  String? get error => _error;

  ChatProvider({required String docId}) {
    _subscription = _db.getMessages(docId: docId).listen(listenToMessages);
  }

  void listenToMessages(QuerySnapshot<Map<String, dynamic>> messages) {
    _loading = false;
    if (messages.docs.isNotEmpty) {
      _messages = messages.docs.map((message) {
        return Message.fromMap(message.data());
      }).toList();
    } else {
      _messages = [];
    }
    notifyListeners();
  }

  void onError(dynamic error) {
    _loading = false;
    _error = 'Something went wrong. Try again.';
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<bool> sendMessage({
    required String text,
    required OwlUser currentUser,
    required OwlUser otherUser,
  }) async {
    try {
      var convoId = generateDocumentId(uid1: currentUser.uid, uid2: otherUser.uid);
      var messageId = const Uuid().v4();
      var message = Message(
        id: messageId,
        message: text,
        senderUid: currentUser.uid,
        receiverUid: otherUser.uid,
        read: false,
        timeStamp: Timestamp.fromDate(
          DateTime.now(),
        ),
      );
      await _db.sendMessage(currentUser: currentUser, otherUser: otherUser, message: message, docId: convoId);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> markMessageAsRead({required Message message, required String docId}) async {
    try {
      await _db.markMessageAsRead(message: message, docId: docId);
    } catch (_) {}
  }
}
