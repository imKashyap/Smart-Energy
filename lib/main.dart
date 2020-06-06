import 'package:flutter/material.dart';
import 'package:smartenergy/screens/home_screen.dart';
import 'package:smartenergy/screens/login_screen.dart';
import 'package:smartenergy/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Energy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: LandingPage(
        auth:  Auth(),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.getCurrentAuthState(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
            final User thisUser = snapshot.data;
            if (thisUser != null)
              return HomeScreen(
                auth: auth,
              );
            else
              return LoginScreen(
                auth: auth,
              );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
