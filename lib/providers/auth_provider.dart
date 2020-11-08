import "dart:convert";

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "../helpers/server_helper.dart";
import "../models/user.dart";

class AuthProvider with ChangeNotifier {
  String _authToken;
  User _user;

  final apiUrl = "${ServerHelper.baseApiUrl}/users";

  String get authToken {
    return _authToken;
  }

  User get user {
    return _user;
  }

  String get userId {
    return _user != null ? _user.id : null;
  }

  bool get isAuth {
    return _authToken != null;
  }

  Future<void> auth(String username, String password) async {
    final response = await ServerHelper.post(
      "$apiUrl/login",
      json.encode(
        {
          "username": username,
          "password": password,
        },
      ),
    );
    final respBody = json.decode(response.body);
    _user = User.parseUJSon(respBody);
    _authToken = response.headers["authorization"];
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("auth_token", _authToken);
    prefs.setString('userData', response.body);
  }

  Future<void> logout() async {
    _authToken = null;
    _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("auth_token")) {
      return false;
    }
    _authToken = prefs.get("auth_token");
    _user = User.parseUJSon(json.decode(prefs.get("userData")));
    notifyListeners();
    return true;
  }
}
