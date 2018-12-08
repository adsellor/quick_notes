import 'package:flutter/material.dart';

import 'noteScreen.dart';

class Notes extends StatelessWidget {
  const Notes({Key key, this.excerpt}) : super(key: key);

  final String excerpt;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.pinkAccent,
            border: Border.all(color: Colors.white30),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: FlatButton(
          onPressed: () {},
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              excerpt,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )),
        ));
  }
}
