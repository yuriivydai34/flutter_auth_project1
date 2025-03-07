import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth_project1/screens/signup_screen.dart';
import 'package:flutter_auth_project1/utils/server.dart';
import 'package:flutter_auth_project1/screens/article_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  static const namedRoute = "login-screen";
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";
  String _error = "";

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  void _login() async {
    String authLocal = await ApiService().postAuthLocal(_email, _password);
    if (authLocal.isNotEmpty) {
      final result = jsonDecode(authLocal) as Map<String, dynamic>;
      var accessToken = result['jwt'];
      if (accessToken == null) {
        setState(() {
          _error = "Your account does not exist.";
        });
      } else {
        await _storage.write(key: 'accessToken', value: accessToken);
        Navigator.pushNamed(context, ArticleScreen.namedRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Column(
                  children: const [
                    SizedBox(height: 150),
                    Text("Strapi App"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (_error.isNotEmpty)
              Column(
                children: [
                  Text(_error, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                ],
              ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password',
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              // ignore: deprecated_member_use
              child: TextButton(
                onPressed: () => _login(),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 130),
            TextButton(
              onPressed: () {
                // navigate to the signup screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Signup()),
                );
              },
              child: const Text(
                'New user? Create Account',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
