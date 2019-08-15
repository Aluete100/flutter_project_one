import 'package:flutter/material.dart';
import 'package:flutter_app_first_project/modules/Pages/signIn.dart';
import 'package:flutter_app_first_project/modules/pages/register.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: logIn,
            child: Text('Log in'),
          ),
          RaisedButton(
            onPressed: register,
            child: Text('Register'),
          )
        ],
      ),
    );
  }

  void logIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void register(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}
