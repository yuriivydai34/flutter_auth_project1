import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_auth_project1/models/user.dart';

class ApiService {
  // Getting users
  Future<List<User>> getUsers() async {
    var url = Uri.parse(dotenv.get('baseUrl') + dotenv.get('usersEndpoint'));
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer ${dotenv.get('accessToken')}"},
    );
    return userFromJson(response.body);
  }
}
