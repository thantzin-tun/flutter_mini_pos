import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/styles.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';

class AlertUtil {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class AlertUtilTop {
  static void showSnackBar(BuildContext context, String text) {
    FloatingSnackBar(
      message: text,
      context: context,
      textStyle: KTextStyle.deleteTextStyle.copyWith(fontSize: 14.0),
      duration: const Duration(milliseconds: 3000),
      backgroundColor: KColor.NORMAL_COLOR,
    );
  }

  static void showSnackBarTop(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.up,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.87,
          left: 15,
          right: 15),
      content: Text(
        text,
        style: KTextStyle.deleteTextStyle.copyWith(fontSize: customFontSize),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: KColor.NORMAL_COLOR,
    ));
  }
}
