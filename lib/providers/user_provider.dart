import 'package:flutter/foundation.dart';
import '../models/app_user.dart';

class UserProvider extends ChangeNotifier {
  AppUser _user = AppUser(
    name: 'Ahmed Hassan',
    email: 'player@example.com',
    birthdate: DateTime(2000, 5, 14),
    role: 'Player',
  );

  AppUser get user => _user;
  String get firstName => _user.name.trim().split(' ').first;

  void updateName(String name) {
    _user = _user.copyWith(name: name.trim());
    notifyListeners();
  }
}
