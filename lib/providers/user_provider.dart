import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userId;

  String? get userId => _userId;

  get address => null;

  get phone => null;

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void updateProfile({required String phone, required String address}) {}
}