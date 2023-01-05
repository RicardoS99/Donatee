import 'package:com/services/auth.dart';
import 'package:com/widgets/authentication/createaccountlink.dart';
import 'package:com/widgets/authentication/enterorgbutton.dart';
import 'package:com/widgets/authentication/forgotpasslink.dart';
import 'package:com/widgets/authentication/loginbutton.dart';
import 'package:flutter/material.dart';
import 'package:com/shared/constants.dart';
import 'package:com/widgets/common/loading.dart';
import 'package:com/widgets/authentication/authlogo.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  //Bool to change buttons'colors when tapped
  bool logintapped = false;
  bool entertapped = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 15.0, 0.0),
                    child: AuthLogo()),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                        Container(
                          alignment: Alignment(1.0, 0),
                          padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: ForgotPasswordLink(),
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 5.0),
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            setState(() => logintapped = true);
                          },
                          onTapUp: (TapUpDetails details) {
                            setState(() => logintapped = false);
                          },
                          onTapCancel: () {
                            setState(() => logintapped = false);
                          },
                          onTap: () async {
                            logintapped = false;
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signInEmail(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Invalid email and/or password';
                                  loading = false;
                                });
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "/userhome");
                              }
                            }
                          },
                          child: LoginButton(istapped: logintapped),
                        ),
                        SizedBox(height: 12.0),
                        GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            setState(() => entertapped = true);
                          },
                          onTapUp: (TapUpDetails details) {
                            setState(() => entertapped = false);
                          },
                          onTapCancel: () {
                            setState(() => entertapped = false);
                          },
                          onTap: () async {
                            entertapped = false;
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signInOrg(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Organization not found. Check credentials.';
                                  loading = false;
                                });
                              } else {
                                Navigator.pushReplacementNamed(
                                    context, "/orghome");
                              }
                            }
                          },
                          child: EnterAsOrgButton(istapped: entertapped),
                        ),
                        SizedBox(height: 12.0),
                        CreateAccountPack()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
  }
}
