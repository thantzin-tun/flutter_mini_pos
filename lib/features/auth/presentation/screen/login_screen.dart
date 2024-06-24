import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/constants/strings.dart';
import 'package:flutter_bloc_demo/constants/styles.dart';

import 'package:flutter_bloc_demo/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/screens/home_screen.dart';

import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/utils/alert_util.dart';
import 'package:flutter_bloc_demo/widgets/custom_button.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';
import 'package:flutter_bloc_demo/widgets/sizeBox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          AlertUtilTop.showSnackBar(context, state.message);
          isLoading = false;
        } else if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        }
      },
      builder: (context, state) {
        return Container(
          color: const Color.fromARGB(255, 244, 248, 244),
          padding: const EdgeInsets.all(PRODUCT_CARD_SPACING),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/pos.png"),
                    ],
                  ),
                  const CustomTextWidget(
                    text: "အကောင့်ဝင်ရန်",
                    fontColor: KColor.SECONDARY_COLOR,
                    fontSize: primaryFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  const CustomSizeBox(
                    height: loginPadding,
                  ),
                  TextFormField(
                    controller: usernameController,
                    cursorColor: KColor.PRIMARY_COLOR,
                    decoration: InputDecoration(
                      label: const CustomTextWidget(text: email),
                      floatingLabelStyle: KTextStyle.TextFieldStyle,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
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
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 56,
                        minWidth: 56,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 18, right: 8),
                        child: Icon(
                          Icons.person,
                          color: KColor.PRIMARY_COLOR,
                        ),
                      ),
                      hintStyle: KTextStyle.TextFieldStyle.copyWith(
                        color: KColor.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  const CustomSizeBox(
                    height: loginPadding,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: KColor.PRIMARY_COLOR,
                    decoration: InputDecoration(
                      label: const CustomTextWidget(text: password),
                      floatingLabelStyle: KTextStyle.TextFieldStyle,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
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
                      prefixIconConstraints: const BoxConstraints(
                        minHeight: 56,
                        minWidth: 56,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 18, right: 8),
                        child: Icon(
                          Icons.key,
                          color: KColor.PRIMARY_COLOR,
                        ),
                      ),
                      hintStyle: KTextStyle.TextFieldStyle.copyWith(
                        color: KColor.PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  const CustomSizeBox(
                    height: loginPadding,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: KColor.PRIMARY_COLOR,
                            ))
                          : CustomButton(
                              text: login,
                              action: () {
                                if (usernameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  BlocProvider.of<LoginCubit>(context).signIn(
                                      usernameController.text.toString(),
                                      passwordController.text.toString());
                                } else {
                                  AlertUtilTop.showSnackBar(
                                      context, errLoginText);
                                }
                              }))
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
