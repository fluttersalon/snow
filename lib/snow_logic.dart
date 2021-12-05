import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'data/snow_data.dart';

class SnowLogic {
  Random _random = Random();

  final Size displaySize;
  SnowLogic(this.displaySize);

  SnowData generate(
    int index,
    double minSize,
    double maxSize,
  ) {
    return SnowData(
      key: ObjectKey('snow_$index'),
      snowKey: ObjectKey('snowKey_$index'),
      x: _random.nextDouble() * displaySize.width,
      y: _random.nextDouble() * displaySize.height,
      size: (maxSize - minSize) * _random.nextDouble() + minSize,
    );
  }

  SnowData fall(SnowData snow, double speed) {
    double x = snow.x + 0.3 * speed * (_random.nextDouble() - 0.5);
    double y = snow.y + speed / 3 + 2 * speed * _random.nextDouble() / 3;
    y = displaySize.height < y ? -5 : y;

    var newSnow = snow.copyWith(x: x, y: y);
    return newSnow;
  }
}
