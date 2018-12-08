import "dart:io";

import "package:flutter/material.dart";
import "package:path_provider/path_provider.dart";
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import "package:image_picker/image_picker.dart";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isProccessing = false;
  String _visionText;
  File _image;

  Future<Null> _getImage() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final image = await ImagePicker.pickImage(source: ImageSource.camera);

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);
    for (TextBlock block in visionText.blocks) {
      final boundingBox = block.boundingBox;
      final cornerPoints = block.cornerPoints;
      final String text = block.text;
      print(boundingBox);
      print(cornerPoints);
      print(text);
    }

    print(visionText.text);
    setState(() {
      _image = image;
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
          child: Center(child: Image.file(_image)),
        ));
  }
}
