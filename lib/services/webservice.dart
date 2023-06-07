import 'dart:convert';
import 'package:bipixapp/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Webservice {
  static Future<String> getUserId() async =>
      (await SharedPreferences.getInstance()).getString("USER_ID")!;

  static Future<Response> post({
    required String function,
    required Map body,
    void Function(Map e)? onError,
  }) async {
    final Response response = await http.post(
      Uri.parse('$baseUrl/$function'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(body),
    );
    if ([200, 201].contains(response.statusCode)) {
    } else {
      if (onError != null) {
        onError({"error": response.body, "statusCode": response.statusCode});
      }
    }
    return response;
  }
}
