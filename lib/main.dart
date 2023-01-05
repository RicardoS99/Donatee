import 'package:com/screens/authentication/forgotpass.dart';
import 'package:com/screens/authentication/register.dart';
import 'package:com/screens/authentication/sign_in.dart';
import 'package:com/screens/organization/orgpage.dart';
import 'package:com/screens/user/success.dart';
import 'package:com/screens/user/userhome.dart';
import 'package:flutter/material.dart';
import 'package:com/splashpage.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);//This locks screen rotation
      
    return MaterialApp(
      title: 'Donatee',
      theme: buildDonateeTheme(),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/userhome': (BuildContext context) => UserHome(),
        '/orghome': (BuildContext context) => OrgPage(),
        '/login': (BuildContext context) => SignIn(),
        '/register': (BuildContext context) => Register(),
        '/recovery':(BuildContext context) => ForgotPass(),
        '/success': (BuildContext context) => Success(),
      });
  }

//Customize theme here
  ThemeData buildDonateeTheme() {
    return ThemeData(

      //Default Brightness
      //brightness: Brightness.light,

      //General Colors
      primarySwatch: Colors.cyan, //palete
      primaryColor: Colors.cyan[800], //primary color (appbar, circleavatar...)
      primaryColorDark: Colors.cyan[900], //darker shade of primary color
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      highlightColor: Colors.cyan[200],
      buttonColor: Colors.cyan[900],

      //Floating Action Buttons Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4.0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.cyan[800],
        
      ),

      //General Fonts
      fontFamily: 'Montserrat',
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 26.0, letterSpacing: 2.0),
        headline5: TextStyle(fontSize: 26.0, letterSpacing: 2.0),
      ),


      //App Bar Theme
      appBarTheme: AppBarTheme(
        color: Colors.white,
        actionsIconTheme: IconThemeData(color: Colors.cyan[800]),
        iconTheme: IconThemeData(color: Colors.cyan[800]),
        elevation: 4.0,
        textTheme: TextTheme(
        headline6: TextStyle(fontFamily: 'Montserrat', fontSize: 26.0, letterSpacing: 1.0, color: Colors.cyan[800]),
      ),
        
        )
    );
  }
}