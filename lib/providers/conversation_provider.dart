import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:owl/models/conversation.dart';
import 'package:owl/services/database_service.dart';

class ConversationProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;

  late StreamSubscription<QuerySnapshot<Conversation>> _subscription;

  bool _loading = true;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  ConversationProvider({required String uid}) {
    _subscription = _db.getConversations(uid: uid).listen(listenToConversations, onError: onError);
  }

  void listenToConversations(QuerySnapshot<Conversation> snapshot) {
    _loading = false;
    _error = null;
    _conversations = snapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  void onError(dynamic error) {
    _loading = false;
    _error = 'Something went wrong while fetching your messages!';
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
