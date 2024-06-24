import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_demo/constants/dimensions.dart';
import 'package:flutter_bloc_demo/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';

import 'package:flutter_bloc_demo/resources/colors.dart';
import 'package:flutter_bloc_demo/resources/const.dart';
import 'package:flutter_bloc_demo/widgets/custom_text_widget.dart';
import 'package:flutter_bloc_demo/widgets/sizeBox.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = "";
  String themeModeStatus = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColor.PRIMARY_COLOR,
        // leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: CustomTextWidget(
          text: AppLocalizations.of(context)!.pos,
          fontSize: primaryFontSize,
          fontColor: KColor.NORMAL_COLOR,
        ),
      ),
      drawer: Drawer(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Image.asset(
              "assets/icons/background.jpg",
              width: double.infinity,
              height: size.height * 0.3,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: size.height * 0.20,
              left: size.width * 0.1,
              child: Container(
                width: 200.0, // 2 * radius
                height: 200.0, // 2 * radius
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: KColor
                        .PRIMARY_COLOR, // Replace with your desired border color
                    width: 4.0, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 100.0,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/icons/background.jpg",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: size.height * 0.42,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomTextWidget(
                      fontColor: KColor.SECONDARY_COLOR,
                      text: "ထက်ထက် ( ကလေးလေး )",
                    ),
                    const CustomSizeBox(
                      height: SECONDARY_GAP,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginSuccess) {
                          final email = state.response.user!.username;
                          return CustomTextWidget(
                              fontColor: KColor.SECONDARY_COLOR,
                              text: email.toString());
                        }
                        return const CustomTextWidget(
                            fontColor: KColor.SECONDARY_COLOR,
                            text: "unknownuser@gmail.com");
                      },
                    ),
                    const CustomSizeBox(
                      height: loginPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PRIMARY_PADDING),
                      child: ListTile(
                        tileColor: KColor.PRIMARY_COLOR,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(PRIMARY_RADIUS)),
                        leading: const Icon(
                          Icons.phone,
                          color: KColor.NORMAL_COLOR,
                        ),
                        trailing: const CustomTextWidget(
                          text: "09 954788345",
                          fontColor: KColor.NORMAL_COLOR,
                        ),
                      ),
                    ),
                    const CustomSizeBox(
                      height: PRIMARY_GAP,
                    ),
                    BlocConsumer<ThemeBloc, ThemeState>(
                      listener: (context, state) {
                        if (state is ThemeChanged) {
                          themeModeStatus = state.mode;
                          logger("Mode", themeModeStatus);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PRIMARY_PADDING),
                          child: ListTile(
                            onTap: () {
                              if (themeModeStatus == "light") {
                                context.read<ThemeBloc>().add(LightModeEvent());
                              } else {
                                context.read<ThemeBloc>().add(DarkModeEvent());
                              }
                            },
                            tileColor: KColor.PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(PRIMARY_RADIUS)),
                            leading: themeModeStatus == "dark"
                                ? const Icon(
                                    Icons.nights_stay,
                                    color: KColor.NORMAL_COLOR,
                                  )
                                : const Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                  ),
                            trailing: CustomTextWidget(
                              text: themeModeStatus == "dark"
                                  ? "Dark Mode"
                                  : "Light Mode",
                              fontColor: KColor.NORMAL_COLOR,
                            ),
                          ),
                        );
                      },
                    ),
                    const CustomSizeBox(
                      height: PRIMARY_GAP,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PRIMARY_PADDING),
                      child: ListTile(
                        onTap: () {},
                        tileColor: KColor.PRIMARY_COLOR,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(PRIMARY_RADIUS)),
                        leading: const Icon(
                          Icons.flag,
                          color: KColor.NORMAL_COLOR,
                        ),
                        trailing: const CustomTextWidget(
                          text: "Language",
                          fontColor: KColor.NORMAL_COLOR,
                        ),
                      ),
                    ),
                  ],
                  // Or any color you want to overlay
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(PRIMARY_PADDING),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSizeBox(
              height: 10.0,
            ),
            const CustomTextWidget(
              text: "Today",
              fontSize: secondaryFontSize,
              fontWeight: FontWeight.bold,
              fontColor: KColor.SECONDARY_COLOR,
            ),
            const CustomSizeBox(
              height: 10.0,
            ),
            const DailyInformationWidget(
              value: "245999999 ကျပ်",
              statusText: "Revenue",
              image: "assets/images/revenue.png",
            ),
            const CustomSizeBox(
              height: 5.0,
            ),
            const DailyInformationWidget(
              value: "0",
              statusText: "Sold orders",
              image: "assets/images/sale_order.png",
            ),
            const CustomSizeBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 5.0, // Spacing between columns
                  mainAxisSpacing: 5.0, // Spacing between rows
                ),
                itemCount: 4, // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  return MenuCategory(
                      statusText: homeIconList[index]["statusText"],
                      route: homeIconList[index]["route"],
                      image: homeIconList[index]["image"]);
                },
              ),
            ),
            const Center(
                child: CustomTextWidget(
              text: "@Copyright by Thant Zin Tun",
              fontColor: KColor.SECONDARY_COLOR,
            )),
            const CustomSizeBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCategory extends StatefulWidget {
  const MenuCategory(
      {super.key,
      required this.image,
      required this.statusText,
      required this.route});

  final String image;
  final String statusText;
  final String route;

  @override
  State<MenuCategory> createState() => _MenuCategoryState();
}

class _MenuCategoryState extends State<MenuCategory> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: KColor.PRIMARY_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            PRIMARY_RADIUS), // Customize the border radius here
      ),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(widget.route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.image),
            const CustomSizeBox(
              height: PRIMARY_GAP,
            ),
            CustomTextWidget(
              text: widget.statusText,
              fontSize: customFontSize,
              fontColor: KColor.SECONDARY_COLOR,
            )
          ],
        ),
      ),
    );
  }
}

class DailyInformationWidget extends StatelessWidget {
  final String image;
  final String statusText;
  final String value;

  const DailyInformationWidget(
      {super.key,
      required this.image,
      required this.statusText,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(PRIMARY_RADIUS)),
      child: Card(
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.125,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: KColor.PRIMARY_COLOR,
            width: 3.0,
          ))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 120.0,
                height: double.infinity,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextWidget(
                      text: statusText,
                      fontSize: tinaryFontSize,
                      fontColor: KColor.SECONDARY_COLOR,
                    ),
                    const CustomSizeBox(
                      height: 10.0,
                    ),
                    CustomTextWidget(
                      text: value,
                      fontSize: secondaryFontSize,
                      fontColor: KColor.SECONDARY_COLOR,
                    )
                  ],
                ),
              ),
              const CustomSizeBox(
                width: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
