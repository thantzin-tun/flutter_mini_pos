import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/constants/styles.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget(
      {super.key,
      this.onChanged,
      this.onSubmitted,
      this.suffixIconOnTap,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText = '',
      this.obscureText,
      this.contentPadding,
      this.enabled,
      this.fillColor,
      this.label,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.keyboardType,
      this.controller,
      this.validator,
      this.initialValue,
      required this.onSaved});

  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSubmitted;
  final Function()? suffixIconOnTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? obscureText;
  final bool? enabled;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final Widget? label;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String?) onSaved;
  final dynamic initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enabled,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      // controller: controller,
      obscureText: obscureText ?? false,
      cursorColor: KColor.PRIMARY_COLOR,
      textInputAction: textInputAction,
      style: KTextStyle.TextFieldStyle,
      validator: validator,
      onSaved: onSaved,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: label,
        floatingLabelStyle: KTextStyle.TextFieldStyle,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KColor.PRIMARY_COLOR,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KColor.PRIMARY_COLOR,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KColor.PRIMARY_COLOR,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KColor.TRINARY_COLOR,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: KColor.TRINARY_COLOR,
          ),
        ),
        hintText: hintText,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 56,
          minWidth: 56,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 18, right: 8),
                child: prefixIcon,
              )
            : null,
        hintStyle: KTextStyle.TextFieldStyle.copyWith(
          color: KColor.PRIMARY_COLOR,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
