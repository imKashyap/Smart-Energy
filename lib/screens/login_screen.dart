import 'package:flutter/material.dart';
import 'package:smartenergy/services/auth.dart';
import 'package:smartenergy/widgets/signin_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({@required this.auth});
  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    final spacebox = SizedBox(
      height: 50.0,
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 40.0, right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Smart Energy',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(
                      height: 20.0,
                      color: Colors.green[800],
                    ),
                    Text(
                      'It\'s time to bring a change. ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                spacebox,
                spacebox,
                SignInButton(
                  icon: Image.asset('assets/images/google-logo.png'),
                  signInText: 'Sign in with Google',
                  onPressed:_signInWithGoogle,
                  color: Colors.white,
                  textColor: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print('message=$e');
    }
  }
  
}
