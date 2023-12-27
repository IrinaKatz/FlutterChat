import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {

  static late final SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void loginUser(String username, String password) {
    try {
      _prefs.setString('username', username);

    } catch(e) {
      print(e);
    }
  }

  void logoutUser() {
    try {
      _prefs.clear();
    } catch(e) {
      print(e);
    }
  }

  Future<bool> isLoggedIn() async {
    return await _prefs.get('username')!= null;
  }

  String getUsername() {
    String username = 'User';
      if (_prefs.get('username')!= null) {
        username = _prefs.getString('username')!;
    }
      return username;
  }
}