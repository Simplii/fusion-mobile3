import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/callactionbutton.dart';

import 'backend/fusion_connection.dart';

class LoginView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Function(String username, String password) _onLogin;

  LoginView(this._onLogin, this._fusionConnection, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  Function(String username, String password) get _onLogin => widget._onLogin;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _wasSuccessful = null;

  _usernameInput() {
    return Flexible(
        child: TextField (
            decoration: const InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid
                )),
                hintText: "Username"),
            controller: _usernameController
        )
    );
  }

  _passwordInput() {
    return Flexible(
        child: TextField (
          obscureText: true,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid
                )),
                hintText: "Password"),
            controller: _passwordController
        )
    );
  }

  _loginButton() {
    return ElevatedButton(
      onPressed: _login,
      child: Text("Login", style: TextStyle(color: Colors.white))
    );
  }

  _login() {
    _fusionConnection.login(
        _usernameController.value.text,
        _passwordController.value.text,
            (bool success) {
              if (success) {
                _wasSuccessful = true;
                _onLogin(
                    _usernameController.value.text,
                    _passwordController.value.text);
              }
              else {
                _wasSuccessful = false;
              }
              this.setState(() {});
            }
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top:8, bottom: 18),
                child: Center(
                    child: Text("Sign in to your account",
                        style: TextStyle(fontSize:18)))))
      ]),
      Row(children:[ _usernameInput() ]),
      Row(children:[ _passwordInput() ])
    ];

    if (_wasSuccessful == false) {
      children.add(Row(children: [
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 16, bottom: 0),
                child: Center(
                    child: Text("Incorrect username or password",
                        style: TextStyle(color: Colors.red)))))
      ]));
    }

    children.add(
        Row(children:[
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(top:18),
                  alignment: Alignment.centerRight,
                  child: _loginButton() ))])
    );

    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 242,241,241)),
            child: Column(
              children: [
                Row(children: [
                  Expanded( child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 96, bottom: 8),
                        child: Text("Fusion Mobile",
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)))))
                ]),
                Row(children: [
                  Expanded(child:
                  Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Color.fromARGB(255,255,255,255)),
                      margin: EdgeInsets.only(left:32.0,right:32.0,top:24.0),
                      width: 100,
                      child: Column(
                          children: children
                      )
                  )
                  )
                ])
              ],
            )
    );
  }
}