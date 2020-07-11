import 'package:flutter/material.dart';
import 'package:tacky/widgets/main_container.dart';

void main() {
  runApp(Tracky());
}

class Tracky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tacky'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.sentiment_very_satisfied), onPressed: ()=>{},
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: MainContainer(),
      ),
    );
  }
}