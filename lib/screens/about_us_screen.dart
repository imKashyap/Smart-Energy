import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Card(
        margin: const EdgeInsets.all(50.0),
        color: Colors.amber[400],
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Team Members',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(
          height: 30.0,
        ),
            buildContactRow('Anubhav Gupta','https://www.linkedin.com/in/anubhav-gupta-a9b432187/'),
            buildContactRow('Shweta Bharti','https://www.linkedin.com/in/shweta-bharti-466381175/'),
             buildContactRow('Pritika Baranwal','https://www.linkedin.com/in/rahul-kashyap-230577195'),
             buildContactRow('Aditya Pratyush','https://www.linkedin.com/in/aditya-pratyush/'),
            buildContactRow('Rahul Kashyap','https://www.linkedin.com/in/rahul-kashyap-230577195'),
          ],
        ),
      ),
    );
  }

  Row buildContactRow(String name,[String url] ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(
          width: 5.0,
        ),
        name!='Pritika Baranwal'?InkWell(
          child: Icon(FontAwesomeIcons.linkedin, color: Colors.blue, size: 20),
          onTap: () =>
              launch(url),
        ):Container(),
        SizedBox(
          width: 3.0,
        ),
      ],
    );
  }
}

