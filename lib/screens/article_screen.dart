import 'package:flutter/material.dart';
import 'package:flutter_auth_project1/models/article.dart';
import 'package:flutter_auth_project1/utils/server.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArticleScreen extends StatefulWidget {
  static String namedRoute = 'articles-screen';

  const ArticleScreen({super.key});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  List<Article> _articles = [];
  String _error = "";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      _articles = await ApiService().getArticles();
      Future.delayed(const Duration(seconds: 1)).then(
        (value) => setState(() {
          _articles = _articles;
          _error = "";
        }),
      );
    } on Exception catch (e) {
      _error = e.toString();
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
              itemCount: _articles.length,
              itemBuilder: (context, index) {
                var article = _articles[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (article.image != null)
                      Image.network(article.image),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(article.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
