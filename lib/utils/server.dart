import 'dart:convert';

import 'package:flutter_auth_project1/models/article.dart';
import 'package:flutter_auth_project1/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Post Auth Local
  Future postAuthLocal(String email, String password) async {
    var url = Uri.parse(
      dotenv.get('baseUrl') + dotenv.get('authLocalEndpoint'),
    );
    var response = await http.post(
      url,
      body: {"identifier": email, "password": password},
    );
    return response.body;
  }

  // Adding user
  Future<User?> addUser(String email, String username, String password) async {
    try {
      Object jsonBody = {
        "email": email,
        "username": username,
        "password": password,
        "confirmed": 'true',
        "role": '1',
      };
      var url = Uri.parse(dotenv.get('baseUrl') + dotenv.get('usersEndpoint'));
      var response = await http.post(url, body: jsonBody);

      if (response.statusCode == 201) {
        User _model = singleUserFromJson(response.body);
        return _model;
      } else {
        String error = jsonDecode(response.body)['error']['message'];
        throw Exception(error);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Getting articles
  Future<List<Article>> getArticles() async {
    try {
      var url = Uri.parse(dotenv.get('baseUrl') + dotenv.get('articlesEndpoint'));
      var accessToken = await _storage.read(key: 'accessToken');
      var response = await http.get(
        url,
        headers: {"Authorization": "Bearer ${accessToken}"},
      );
      if (response.statusCode == 200) {
        var _model = articleFromJson(jsonDecode(response.body)['data']);
        return _model;
      } else {
        throw Exception(jsonDecode(response.body)["error"]["message"]);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
