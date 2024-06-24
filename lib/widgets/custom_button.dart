import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.action,
      required this.text,
      this.backgroundColor = KColor.PRIMARY_COLOR,
      this.textColor = KColor.NORMAL_COLOR});
  final VoidCallback action;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PRIMARY_RADIUS),
        ),
      ),
      onPressed: action,
      child: CustomTextWidget(
        text: text,
        fontColor: textColor,
      ),
    );
  }
}
