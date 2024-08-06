import 'package:flutter/material.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/services/database_service.dart';

class SearchProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();

  List<OwlUser> _owlUsers = [];
  List<OwlUser> get owlUsers => _owlUsers;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> serchUserByUserName({required String userName}) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _owlUsers = (await _db.getOwlUsers()).where((owlUser) => owlUser.userName.contains(userName)).toList();
    } catch (_) {
      _owlUsers = [];
      _error = "Ooops.. Something went wrong!";
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
