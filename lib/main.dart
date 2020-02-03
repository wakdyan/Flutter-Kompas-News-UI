import 'package:flutter/material.dart';
import 'ui/home.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xff333333),
          accentColor: Color(0xff333333),
          indicatorColor: Color(0xff333333),
          appBarTheme: AppBarTheme(color: Colors.black87)),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Home(),
    ),
  );
}
