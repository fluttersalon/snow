import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snow/snow_logic.dart';
import 'package:timer_builder/timer_builder.dart';
import 'data/snow_data.dart';
import 'gen/assets.gen.dart';
import 'gen/snow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

GlobalKey _keyScaffold = GlobalKey();
const NUMBER_OF_SNOW = 100;
const SPEED_OF_SNOW = 3;
const MIN_SIZE_OF_SNOW = 10.0;
const MAX_SIZE_OF_SNOW = 20.0;
const FRAME_RATE = 1000 / 15;

class _MyHomePageState extends State<MyHomePage> {
  List<Snow> snows = [];
  List<SnowData> snowData = [];
  Timer? _timer;

  late SnowLogic logic;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((callback) {
      RenderBox scaffold =
          _keyScaffold.currentContext?.findRenderObject() as RenderBox;

      logic = SnowLogic(scaffold.size);

      for (int i = 0; i < NUMBER_OF_SNOW; i++) {
        snowData.add(logic.generate(i, MIN_SIZE_OF_SNOW, MAX_SIZE_OF_SNOW));
      }

      _timer =
          Timer.periodic(Duration(milliseconds: FRAME_RATE.ceil()), (timer) {
        List<Snow> newSnows = [];

        for (int i = 0; i < snowData.length; i++) {
          snowData[i] = logic.fall(snowData[i], 10);
        }

        for (var snow in snowData) {
          Snow newSnow = Snow(
            key: snow.snowKey,
            x: snow.x,
            y: snow.y,
            size: snow.size,
          );
          newSnows.add(newSnow);
          // print('${snow.x} ${snow.y}');
        }

        setState(() {
          snows = newSnows;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print('build');
    return Scaffold(
      key: _keyScaffold,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(Assets.imgp4604.assetName),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...snows
        ],
      ),
    );
  }
}
