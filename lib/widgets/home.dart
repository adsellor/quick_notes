import "dart:io";

import "package:flutter/material.dart";
import 'package:mlkit/mlkit.dart';
import "package:image_picker/image_picker.dart";
import "package:unicorndial/unicorndial.dart";
import "package:flare_flutter/flare_actor.dart";

import "./notes.dart";

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isProccessing = false;
  File _image;
  var _notes = Map<String, List<VisionText>>();
  int _id = 0;

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  Future<Null> _getImage(ImageSource source) async {
    setState(() {
      _isProccessing = true;
    });
    final image = await ImagePicker.pickImage(source: source);

    final currentLabels = await detector.detectFromPath(image.path);

    setState(() {
      _image = image;
      _id++;
      _isProccessing = false;
    });
    _notes["note_$_id"] = currentLabels;
  }

  _getNotes() {
    List<Widget> notes = [];
    _notes.values.toList().forEach((elem) {
      return notes.add(Notes(excerpt: elem.first.text));
    });
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        floatingActionButton: UnicornDialer(
            parentButtonBackground: Colors.pinkAccent,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.add),
            childButtons: <UnicornButton>[
              UnicornButton(
                  currentButton: FloatingActionButton(
                      mini: true,
                      child: Icon(Icons.photo),
                      onPressed: () => _getImage(ImageSource.gallery))),
              UnicornButton(
                  currentButton: FloatingActionButton(
                mini: true,
                child: Icon(Icons.camera),
                onPressed: () => _getImage(ImageSource.camera),
              ))
            ]),
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(children: <Widget>[
            FlareActor("assets/sunshine.flr",
                alignment: Alignment.center,
                fit: BoxFit.cover,
                animation: "idle"),
            Center(
              child: Center(
                child: _notes.isEmpty
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "To get started, press the "),
                                    TextSpan(
                                        text: " + ",
                                        style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: " button, and scan a text  ")
                                  ]),
                            )),
                      )
                    : _isProccessing
                        ? Center(child: CircularProgressIndicator())
                        : Container(
                            margin: EdgeInsets.only(top: 20),
                            child: GridView.count(
                              padding: EdgeInsets.all(10),
                              childAspectRatio:
                                  orientation == Orientation.landscape
                                      ? 1.2
                                      : .85,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: _getNotes(),
                            )),
              ),
            )
          ]),
        ));
  }
}
