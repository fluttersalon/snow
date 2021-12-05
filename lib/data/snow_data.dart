import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'snow_data.freezed.dart';

@freezed
class SnowData with _$SnowData {
  const factory SnowData({
    required Key key,
    required Key snowKey,
    required double x,
    required double y,
    required double size,
  }) = _SnowData;
}
