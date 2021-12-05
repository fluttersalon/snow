import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snow/snow_logic.dart';

class Snow extends StatelessWidget {
  final double size;
  static const rate = 0.7;

  static Random _random = Random();

  double x;
  double y;
  double? displayHeight = 1000;

  Snow({
    required this.size,
    required this.x,
    required this.y,
    Key? key,
    this.displayHeight,
  }) : super(key: key);

  Snow.generate(
      {required double minSize,
      required double maxSize,
      required double width,
      required double height})
      : this(
          size: _random.nextDouble() * (maxSize - minSize) + minSize,
          x: width * _random.nextDouble(),
          y: height * _random.nextDouble(),
          displayHeight: height,
        );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: y,
      left: x,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(size * (1 - rate) / 2),
            child: Container(
              width: size * rate,
              height: size * rate,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  void fall(double speed) {
    y += speed;

    if (y > (displayHeight ?? 2000)) {
      y = 0;
    }
  }
}
