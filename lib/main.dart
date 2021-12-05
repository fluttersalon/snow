import 'dart:async';

import 'package:flutter/material.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  List<Snow> snows = [];
  Timer? _timer;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((cb) {
      RenderBox scaffold =
          _keyScaffold.currentContext?.findRenderObject() as RenderBox;

      print("scaffold 高さ${scaffold.size.height}  ${scaffold.size.width}");

      for (int i = 0; i < 5; i++) {
        snows.add(
          Snow.generate(
            minSize: 10,
            maxSize: 20,
            width: scaffold.size.width,
            height: scaffold.size.height,
          ),
        );

        _timer = Timer.periodic(Duration(milliseconds: (1000).ceil()), (timer) {
          print("test");
          for (var snow in snows) {
            snow.fall(10);
            print('${snow.x} ${snow.y}');
          }

          setState(() {
            snows = [...snows];
            print('aaa');
          });
        });
      }

      // AppBarの位置と高さを取得後、setStateメソッドで全体を再描画する
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(Assets.imgp4614.assetName),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Snow(
            size: 15,
            x: 100,
            y: 150,
          ),
          ...snows
        ],
      ),
    );
  }
}
