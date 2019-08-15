import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_first_project/modules/pages/register.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset("assets/vm.png"),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'alanantar@hotmail.com',
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (input) {
        if (input.isEmpty) return 'Porfavor ingrese un email';
        return null;
      },
      onSaved: (input) => _email = input,
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'password',
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      validator: (input) {
        if (input.length < 6)
          return 'Porfavor ingrese una contraseña valida';
        return null;
      },
      onSaved: (input) => _password = input
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 48.0,
        width: 300.0,
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.redAccent,
          child: Text('Log in', style: TextStyle(color: Colors.white)),
          onPressed: signIn,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        '¿Olvidaste tu contraseña?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final createAccountLabel = FlatButton(
      child: Text(
        '¿No tenes cuenta? ¡Create una aca!',
        style: TextStyle(color: Colors.black, fontSize: 15.0),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Center(
              child: Column(
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  loginButton,
                  forgotLabel,
                  SizedBox(height: 100.0),
                  createAccountLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    final ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);

    pr.show();
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        pr.hide();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        pr.hide();
        print(e.toString());
      }
    }
  }
}
