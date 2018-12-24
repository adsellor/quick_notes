import "package:flutter/material.dart";
import 'package:unicorndial/unicorndial.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton(
      {@required this.onPhotoPressed, @required this.onCameraPressed});

  final VoidCallback onPhotoPressed;
  final VoidCallback onCameraPressed;

  @override
  Widget build(BuildContext context) {
    return UnicornDialer(
        parentButtonBackground: Colors.pinkAccent,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: <UnicornButton>[
          UnicornButton(
              currentButton: FloatingActionButton(
            mini: true,
            child: Icon(Icons.photo),
            onPressed: onPhotoPressed,
          )),
          UnicornButton(
              currentButton: FloatingActionButton(
            mini: true,
            child: Icon(Icons.camera),
            onPressed: onCameraPressed,
          ))
        ]);
  }
}
