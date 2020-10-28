import 'package:flutter/material.dart';
import 'package:flutter_newa_app_api/login/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
      ),
      title: 'Flutter News',
      //home: Home(),
      home: SignIn(),
    );
  }
}
