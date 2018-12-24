import "dart:io";

import "package:flutter/material.dart";
import 'package:mlkit/mlkit.dart';
import "package:image_picker/image_picker.dart";
import "package:flare_flutter/flare_actor.dart";

import "noteCard.dart";
import 'noteScreen.dart';
import 'floatingButton.dart';

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

  List<Widget> _getNotesCard() {
    List<Widget> notes = [];
    _notes.values.toList().forEach((note) {
      String noteContent =
          note.fold('', (prev, element) => prev + '\n' + element.text);

      notes.add(NoteCard(
        heroTag: note.toString(),
        excerpt: note.first.text,
        titleTag: note.first.text,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                    heroTag: note.toString(),
                    text: noteContent,
                    title: note.first.text,
                    titleTag: note.first.text,
                  ),
            ),
          );
        },
      ));
    });
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Scan from camera',
          child: Icon(Icons.camera),
          onPressed: () => _getImage(ImageSource.camera),
          // onPhotoPressed: () => _getImage(ImageSource.gallery),
        ),
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
                              children: _getNotesCard(),
                            )),
              ),
            )
          ]),
        ));
  }
}
