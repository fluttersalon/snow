import 'dart:math';

import 'package:flutter/material.dart';

class Snow extends StatelessWidget {
  final double size;
  static const rate = 0.7;

  double x;
  double y;

  Snow({
    required this.size,
    required this.x,
    required this.y,
    Key? key,
  }) : super(key: key);

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
}
