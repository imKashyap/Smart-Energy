import 'package:flutter/material.dart';
import 'package:smartenergy/screens/about_us_screen.dart';
import 'package:smartenergy/screens/more_info_screen.dart';
import 'package:smartenergy/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({@required this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  String detail =
      '''This project proposes to increase the productivity and to monitor the usage of biogas by monitoring and controling the pH value as well as the water level. We will also be monitoring and calulating the bill of total biogas consumption.''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Smart Energy',
        ),
      ),
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          child: Image.asset(
            'assets/images/homepage.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: const EdgeInsets.only(
                top: 50.0, bottom: 50.0, left: 20.0, right: 20.0),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'OUR IDEA',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  detail,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () => launch(
                      'https://aditya-pratyush.github.io/Smart-Enenrgy/'),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Text(
                      'Visit Us',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }

  drawer() {
    return FutureBuilder(
        future: auth.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done)
            return CircularProgressIndicator();
          else {
            final user = snapshot.data;
            String name = user.displayName;
            String email = user.email;
            String photoUrl = user.photoUrl;
            return Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    accountName: Text(
                      name,
                    ),
                    accountEmail: Text(
                      email,
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        photoUrl,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Homepage'),
                    onTap: () => Navigator.pop(context),
                  ),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('More Info'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MoreInfoScreen()));
                      }),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.help),
                      title: Text('About Us'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutUsScreen()));
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    onTap: _signOut,
                    title: Text(
                      'Sign out',
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
