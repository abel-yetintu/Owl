import 'dart:async';

import 'package:flutter/material.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/services/database_service.dart';

class OwlUserProvider extends ChangeNotifier {
  final String uid;

  OwlUser? _owlUser;
  OwlUser? get owlUser => _owlUser;

  bool _loading = true;
  bool get loading => _loading;

  late final StreamSubscription<OwlUser?> _subscription;

  OwlUserProvider({required this.uid}) {
    _subscription = DatabaseService().getOwlUser(uid: uid).listen(_onOwlUserChange);
  }

  _onOwlUserChange(OwlUser? owlUser) {
    if (_loading) {
      _loading = false;
    }
    _owlUser = owlUser;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
}
