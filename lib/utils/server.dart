import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  // Post Auth Local
  Future postAuthLocal(email, password) async {
    var url = Uri.parse(
      dotenv.get('baseUrl') + dotenv.get('authLocalEndpoint'),
    );
    var response = await http.post(
      url,
      body: {"identifier": email, "password": password},
    );
    return response.body;
  }
}
