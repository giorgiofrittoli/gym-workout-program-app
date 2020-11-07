import "dart:convert";

import "package:http/http.dart" as http;

import "../models/bad_api_request_ex.dart";
import "../models/generic_server_error_ex.dart";

class ServerHelper {
  //static const serverUrl = "http://94.177.164.112:8080";
  static const serverUrl = "http://192.168.1.60:8080";
  static const baseApiUrl = serverUrl + "/api/v1";

  static Future<http.Response> post(String url, String jsonBody) async {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    if (response.statusCode != 200 && response.statusCode != 403) {
      throw GenericServerError();
    } else if (response.statusCode == 403) {
      final errors = (json.decode(response.body))["errors"];
      throw BadApiRequestError(errors);
    } else {
      return response;
    }
  }
}
