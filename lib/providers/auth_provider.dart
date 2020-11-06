import "dart:convert";

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import "../helpers/server_helper.dart";

class AuthProvider with ChangeNotifier {
  String _authToken;
  String _userId;

  String get authToken {
    return _authToken;
  }

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return _authToken != null;
  }

  Future<void> auth(String username, String password) async {
    final response = await http.post("${ServerHelper.serverUrl}/login",
        body: json.encode(
          {
            "username": username,
            "password": password,
          },
        ));
    final respBody = json.decode(response.body);
    _userId = respBody["userId"];
    _authToken = response.headers["authorization"];
    notifyListeners();
  }
}
