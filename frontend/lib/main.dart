import 'package:flutter/material.dart';
import 'package:frontend/screens/login.dart';
import 'package:frontend/screens/appointments.dart';
import 'package:frontend/screens/doctors.dart';
import 'package:frontend/screens/hospitals.dart';
import 'package:frontend/screens/radiologies.dart';
import 'package:frontend/screens/pathologies.dart';
import 'package:frontend/screens/resources.dart';
import 'package:frontend/screens/dashboard.dart';
import 'package:frontend/screens/register.dart';
import 'package:frontend/util/authentication.dart';
import 'package:frontend/util/firebase.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  @override
  void initState() {
    FirebaseNotifications().setUpFirebase(context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Medical heal app",
      debugShowCheckedModeBanner: false,
      home: new MainPage(),
      //theme: ThemeData(
      //  accentColor: Colors.white70
      //),
      routes: {
        '/doctors': (context) => Doctors(),
        '/register': (context) => Register(),
        '/appointments': (context) => Appointments(),
        '/hospitals': (context) => Hospitals(),
        '/radiologies': (context) => Radiologies(),
        '/pathologies': (context) => Pathologies(),
        '/resources': (context) => Resources(),
       }
    );
  }
}


class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<String> currentToken;

  @override
  void initState() {
    _getValidToken();
    super.initState();
  }

  void _getValidToken() async{
    currentToken = Authentication.getCurrentToken();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: currentToken, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
          case ConnectionState.done:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            if (snapshot.data == null) {
              return LoginPage();
            }
            else {
              return DashBoard();
            }
        }
        return null; // unreachable
      },
    );
  }
}