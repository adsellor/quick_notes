import 'package:flutter/material.dart';

import 'package:quicknote/widgets/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.pink, accentColor: Colors.redAccent),
      home: HomePage(),
    );
  }
}
