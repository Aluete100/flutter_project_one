import 'package:flutter/material.dart';
import 'package:flutter_app_first_project/modules/Pages/signIn.dart';

import 'modules/Pages/welcomeScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

