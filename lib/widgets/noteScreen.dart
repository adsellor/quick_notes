import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({this.text, this.heroTag, this.title, this.titleTag});

  final String text;
  final String heroTag;
  final String titleTag;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Hero(
              tag: heroTag,
              child: Container(
                  child: Column(children: <Widget>[
                Hero(
                  tag: titleTag,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(title,
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 34)),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: Text(text,
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
              ])),
            ),
          )),
    );
  }
}
