import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth_project1/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleScreen extends StatefulWidget {
  static String namedRoute = 'articles-screen';

  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  List articles = [];

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    var accessToken = await _storage.read(key: 'accessToken');
    print('_storage.read>>> ${accessToken}');
    final response = await http.get(
      Uri.parse('${dotenv.get('baseUrl')}/articles'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${accessToken}',
      },
    );
    if (response.statusCode == 200) {
      print('Raw API Response: ${jsonEncode(response.body)}');
      setState(() {
        articles = jsonDecode(response.body)['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Strapi + Flutter')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                debugPrint(article.toString());
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (article['image'] != null)
                      Image.network('${article['image']}'),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article['title'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(article['description']),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              print('object!!!1111');
              Navigator.pushNamed(context, Login.namedRoute);
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
