import 'package:flutter/material.dart';
import 'package:smartenergy/src/info.dart';

class MoreInfoScreen extends StatefulWidget {
  MoreInfoScreen({Key key}) : super(key: key);
  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Why Biogas?',
        style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            //height: MediaQuery.of(context).size.height*0.5,
            child: ListView.builder(
                itemCount: DataSource.questionAnswers.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text(
                      DataSource.questionAnswers[index]['question'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(DataSource.questionAnswers[index]['answer']),
                      )
                    ],
                  );
                }),
          ),
          Container(
            color: Colors.black,
            //margin: const EdgeInsets.all(15.0),
            // decoration: BoxDecoration(
            //     color: Colors.black,
            //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
            padding: const EdgeInsets.all(15.0),
            child: Text(DataSource.quote,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}
