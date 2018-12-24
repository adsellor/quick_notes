import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {Key key, this.excerpt, this.heroTag, this.onPressed, this.titleTag})
      : super(key: key);

  final String excerpt;
  final String heroTag;
  final String titleTag;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          border: Border.all(color: Colors.white30),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: FlatButton(
        onPressed: onPressed,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Hero(
            tag: titleTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                excerpt,
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )),
      ),
    );
  }
}
