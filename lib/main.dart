// Path: `./lib/main.dart`
import 'package:flutter/material.dart';
import 'package:flutter_auth_project1/screens/article_screen.dart';
import 'package:flutter_auth_project1/screens/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const Home());
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Strapi App",
      home: const Login(),
      routes: {
        ArticleScreen.namedRoute: (ctx) => const ArticleScreen(),
        Login.namedRoute: (ctx) => const Login(),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const ArticleScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const ArticleScreen());
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
