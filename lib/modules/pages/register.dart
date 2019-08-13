import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_first_project/modules/Pages/signIn.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'home.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password, _password2;
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


    final password2 = TextFormField(
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar Password',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        validator: (input) {
          if (input.length < 6)
            return 'Las contraseñas no coinciden';
          return null;
        },
        onSaved: (input) => _password2 = input
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        height: 48.0,
        width: 200.0,
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.redAccent,
          child: Text('Registrarme', style: TextStyle(color: Colors.white)),
          onPressed: register,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Ya tenes cuenta? Ingresa',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              password2,
              SizedBox(height: 24.0),
              loginButton,
              forgotLabel,
            ],
          ),
        ),
      ),
    );
  }


  Future<void> register() async {
    final formState = _formKey.currentState;
    final ProgressDialog pr = new ProgressDialog(context, ProgressDialogType.Normal);

    pr.show();
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        user.sendEmailVerification();
        pr.hide();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.toString());
        pr.hide();
      }
    }
  }
}
