import "dart:convert";

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "../helpers/server_helper.dart";
import "../models/user.dart";

class AuthProvider with ChangeNotifier {
  String? _authToken;
  User? _user;

  final apiUrl = "${ServerHelper.baseApiUrl}/users";

  String? get authToken {
    return _authToken;
  }

  User? get user {
    return _user;
  }

  String? get userId {
    return _user != null ? _user!.id : null;
  }

  bool get isAuth {
    return _authToken != null;
  }

  Future<void> auth(String? username, String? password) async {
    final response = await ServerHelper.post(
      "$apiUrl/login",
      json.encode(
        {
          "username": username,
          "password": password,
        },
      ),
    );
    _updateUser(response.body, response.headers["authorization"]!);
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
    _authToken = prefs.get("auth_token") as String?;
    _user = User.parseUJSon(json.decode(prefs.get("userData") as String));
    notifyListeners();
    return true;
  }

  Future<void> _updateUser(String jsonUser, String authToken) async {
    final prefs = await SharedPreferences.getInstance();

    final respBody = json.decode(jsonUser);
    _user = User.parseUJSon(respBody);
    prefs.setString('userData', jsonUser);

    if (authToken.isNotEmpty) {
      _authToken = authToken;
      prefs.setString("auth_token", _authToken!);
    }
    notifyListeners();
  }

  Future<void> updateUser(Map<String, String?> userData) async {
    final response = await ServerHelper.put(
      "$apiUrl/${_user!.id}",
      json.encode(userData),
      authToken: _authToken!,
    );
    _updateUser(response.body, "");
  }
}
