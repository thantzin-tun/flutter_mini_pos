import 'package:flutter/material.dart';

void logger(String title, dynamic logValue) {
  debugPrint(title);
  debugPrint("------------------");
  debugPrint(logValue.toString());
  debugPrint("------------------");
}
