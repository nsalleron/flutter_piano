import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(FlutterPiano());
}

class FlutterPiano extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Piano',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterPianoScreen(),
    );
  }
}

class FlutterPianoScreen extends StatefulWidget {
  final String title = 'Flutter Piano';

  @override
  _FlutterPianoScreenState createState() => _FlutterPianoScreenState();
}

class _FlutterPianoScreenState extends State<FlutterPianoScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final FocusNode _focusNode = FocusNode();

  void _readTone(String tone) {
    assetsAudioPlayer.open(
      Audio("assets/notes/$tone.mp3"),
    );
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.keyZ)
      _readTone('C');
    else if (event.logicalKey == LogicalKeyboardKey.keyX)
      _readTone('D');
    else if (event.logicalKey == LogicalKeyboardKey.keyC)
      _readTone('E');
    else if (event.logicalKey == LogicalKeyboardKey.keyV)
      _readTone('F');
    else if (event.logicalKey == LogicalKeyboardKey.keyB)
      _readTone('G');
    else if (event.logicalKey == LogicalKeyboardKey.keyN)
      _readTone('A');
    else if (event.logicalKey == LogicalKeyboardKey.keyM)
      _readTone('B');
    else if (event.logicalKey == LogicalKeyboardKey.keyS)
      _readTone('Db');
    else if (event.logicalKey == LogicalKeyboardKey.keyD)
      _readTone('Eb');
    else if (event.logicalKey == LogicalKeyboardKey.keyG)
      _readTone('Gb');
    else if (event.logicalKey == LogicalKeyboardKey.keyH)
      _readTone('Ab');
    else if (event.logicalKey == LogicalKeyboardKey.keyJ) _readTone('Bb');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double whiteWidth = constraints.maxWidth / 7;
            return RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: _handleKeyEvent,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  whiteTile('C', 0, whiteWidth),
                  whiteTile('D', 1, whiteWidth),
                  whiteTile('E', 2, whiteWidth),
                  whiteTile('F', 3, whiteWidth),
                  whiteTile('G', 4, whiteWidth),
                  whiteTile('A', 5, whiteWidth),
                  whiteTile('B', 6, whiteWidth),
                  blackTile('Db', 1, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Eb', 2, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Gb', 4, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Ab', 5, whiteWidth, constraints.maxHeight / 2),
                  blackTile('Bb', 6, whiteWidth, constraints.maxHeight / 2),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget whiteTile(String tone, double position, double whiteWidth) {
    return Positioned(
      top: 0,
      left: position * whiteWidth,
      width: whiteWidth,
      bottom: 0,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        onPressed: () => _readTone('$tone'),
      ),
    );
  }

  Widget blackTile(String tone, double position, double whiteWidth,
      double height) {
    double blackWidth = whiteWidth * 0.60;
    return Positioned(
      top: 0,
      left: position * whiteWidth - blackWidth / 2,
      width: blackWidth,
      height: height,
      child: RawMaterialButton(
        fillColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        onPressed: () => _readTone('$tone'),
      ),
    );
  }
}