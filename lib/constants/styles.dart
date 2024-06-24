import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';

class KTextStyle {
  // ignore: non_constant_identifier_names
  static TextStyle TextFieldStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.16,
    color: KColor.SECONDARY_COLOR,
  );

  static TextStyle deleteTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.16,
    color: KColor.TRINARY_COLOR,
  );

  static TextStyle confirmTextStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: KColor.NORMAL_COLOR,
  );
}
