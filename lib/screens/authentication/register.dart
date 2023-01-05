import 'package:com/services/auth.dart';
import 'package:com/widgets/authentication/loginherelink.dart';
import 'package:com/widgets/authentication/signupbutton.dart';
import 'package:flutter/material.dart';
import 'package:com/shared/constants.dart';
import 'package:com/widgets/common/loading.dart';
import 'package:com/widgets/authentication/registerlogo.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  //Bool to change buttons'colors when tapped
  bool istapped = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
            //This solves the hidden textfield by keyboard problem
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 0.0),
                    child: RegisterLogo()),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Full Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Full name required' : null,
                            onChanged: (val) {
                              setState(() => name = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a valid email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            validator: (val) => val.length < 8
                                ? 'Enter a valid password'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Confirm Password'),
                          obscureText: true,
                          validator: (val) =>
                              val != password ? 'Password do not match' : null,
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 5.0),
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            setState(() => istapped = true);
                          },
                          onTapUp: (TapUpDetails details) {
                            setState(() => istapped = false);
                          },
                          onTapCancel: () {
                            setState(() => istapped = false);
                          },
                          onTap: () async {
                            istapped = false;
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.registerEmail(
                                  email, password, name);
                              if (result == null) {
                                setState(() {
                                  error = 'Couldn\'t create account';
                                  loading = false;
                                });
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, "/userhome", (_) => false);
                              }
                            }
                          },
                          child: SignUpButton(istapped: istapped),
                        ),
                        SizedBox(height: 12.0),
                        LoginHereLink()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
}
