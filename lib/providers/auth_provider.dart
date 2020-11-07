import "dart:convert";

import 'package:flutter/material.dart';

import "../helpers/server_helper.dart";
import "../models/user.dart";

class AuthProvider with ChangeNotifier {
  String _authToken;
  User _user;

  final apiUrl = "${ServerHelper.baseApiUrl}/users";

  String get authToken {
    return _authToken;
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
  }
}
