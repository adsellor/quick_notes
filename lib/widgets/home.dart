import "dart:io";

import "package:flutter/material.dart";
import 'package:mlkit/mlkit.dart';
import "package:image_picker/image_picker.dart";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isProccessing = false;
  File _image;
  List<VisionText> _currentLabels = <VisionText>[];

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  Future<Null> _getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    final currentLabels = await detector.detectFromPath(image.path);

    for (VisionText text in currentLabels) {
      print(text.text);
    }

    setState(() {
      _image = image;
      _currentLabels = currentLabels;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _getImage,
          child: Icon(Icons.camera),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: _image == null
              ? Text("Pick an image ya jerk")
              : Image.file(_image),
        ));
  }
}
