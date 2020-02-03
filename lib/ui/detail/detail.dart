import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final String content;

  Detail(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: ListView(
        children: <Widget>[
          Text(content),
        ],
      ),
    );
  }
}
