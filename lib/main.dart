import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

final num vh = MediaQueryData.fromWindow(window).size.height;
final num vw = MediaQueryData.fromWindow(window).size.width;

void main() => runApp(MyApp());

Color _generateNewColor() {
  var randR = Random().nextInt(255);
  var randG = Random().nextInt(255);
  var randB = Random().nextInt(255);
  return Color.fromRGBO(randR, randG, randB, 1);
}

class MyAppState extends State<MyApp> {
  Color backgroundColor = Colors.transparent;
  num biggerSide;
  Axis axe;
  var generateTree = true;
  var startTreeCounter = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: new AppBar(
            title: new Text("Flutter Test App", style: TextStyle(fontSize: 24)),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.refresh),
                  onPressed: () async {
                    setState(() {
                      generateTree = false;
                    });
                  })
            ]
          ),
          body: generateTree
          ? new FlexChild(vh, vw, startTreeCounter)
          : new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              setState(() {
                generateTree = true;
                startTreeCounter = 2;
              });
            },
            child: new Container(color: _generateNewColor()),
          ),
    ));
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class FlexChildState extends State<FlexChild> {
  Axis _axis;
  num recursiveCounter;
  num _vh;
  num _vw;

  FlexChildState(num height, num width, num counter) {
    recursiveCounter = counter;
    if (height > width) {
      _vh = height / 2;
      _vw = width;
      _axis = Axis.vertical;
    } else {
      _vh = height;
      _vw = width / 2;
      _axis = Axis.horizontal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          recursiveCounter++;
        });
      },
      child: recursiveCounter > 0
          ? Flex(
              direction: _axis,
              children: <Widget>[
                Expanded(
                    child: new FlexChild(_vh, _vw, recursiveCounter), flex: 5),
                Expanded(
                    child: new FlexChild(_vh, _vw, recursiveCounter), flex: 5)
              ],
            )
          : new Container(color: _generateNewColor()),
    );
  }
}

class FlexChild extends StatefulWidget {
  num recursiveCounter;
  num _vh;
  num _vw;

  FlexChild(num height, num width, num counter) {
    _vh = height;
    _vw = width;
    recursiveCounter = counter - 1;
  }

  @override
  State<StatefulWidget> createState() {
    return FlexChildState(_vh, _vw, recursiveCounter);
  }
}
