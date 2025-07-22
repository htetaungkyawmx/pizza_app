import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _name;
  String? _email;
  String? _phone;
  String? _address;

  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get address => _address;

  void setUser({
    required String userId,
    required String name,
    required String email,
    String? phone,
    String? address,
  }) {
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
    _address = address;
    notifyListeners();
  }

  void updateProfile({
    String? name,
    String? phone,
    String? address,
  }) {
    if (name != null) _name = name;
    if (phone != null) _phone = phone;
    if (address != null) _address = address;
    notifyListeners();
  }

  void clearUser() {
    _userId = null;
    _name = null;
    _email = null;
    _phone = null;
    _address = null;
    notifyListeners();
  }
}
