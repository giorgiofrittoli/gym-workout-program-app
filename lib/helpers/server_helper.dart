import "dart:convert";

import "package:http/http.dart" as http;

import '../models/exceptions/bad_api_request_ex.dart';
import '../models/exceptions/generic_server_error_ex.dart';

class ServerHelper {
  //static const serverUrl = "http://94.177.164.112:8080";
  static const serverUrl = "http://192.168.1.50:8080";
  static const baseApiUrl = serverUrl + "/api/v1";

  static http.Response _handleResponse(http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 403) {
      throw GenericServerError();
    } else if (response.statusCode == 403) {
      final errors = (json.decode(response.body))["errors"];
      throw BadApiRequestError(errors);
    } else {
      return response;
    }
  }

  static Future<http.Response> post(String url, String jsonBody) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonBody,
    );
    return _handleResponse(response);
  }

  static Future<http.Response> put(
      String url, String jsonBody, String authToken) async {
    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Authorization": authToken,
        "Content-Type": "application/json",
      },
      body: jsonBody,
    );
    return _handleResponse(response);
  }

  static Future<http.Response> get(String url, String authToken) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": authToken,
        "Content-Type": "application/json",
      },
    );
    return _handleResponse(response);
  }
}
