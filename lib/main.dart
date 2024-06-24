import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/routes.dart';
import 'package:flutter_bloc_demo/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_bloc_demo/features/customer/presentation/screens/customer_screen.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc_demo/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_demo/features/home/presentation/screens/landing_screen.dart';
import 'package:flutter_bloc_demo/features/order/presentation/screens/order_screen.dart';
import 'package:flutter_bloc_demo/features/product/presentation/screens/product_detail_screen.dart';
import 'package:flutter_bloc_demo/features/product/presentation/screens/product_screen.dart';
import 'package:flutter_bloc_demo/features/product/presentation/screens/prouduct_create.dart';
import 'package:flutter_bloc_demo/firebase_options.dart';
import 'package:flutter_bloc_demo/helpers/bloc_register.dart';
import 'package:flutter_bloc_demo/services/locator.dart';
import 'package:flutter_bloc_demo/services/store.dart';

//localization
//install flutter pub add flutter_localizations --sdk=flutter intl:any
//lib/l10n/app_en.arb or app_my.arb (country text code)
//flutter gen-l10n
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  locator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocRegister(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'HTET HTET',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
              useMaterial3: false,
            ),
            themeMode: state is ThemeChanged && state.mode == "light"
                ? ThemeMode.light
                : ThemeMode.dark,
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale: const Locale('en'),
            supportedLocales: const [
              Locale('en'),
              Locale('my'),
            ],
            initialRoute: AppRoute.home,
            routes: {
              AppRoute.home: (context) => const HomeScreen(),
              AppRoute.login: (context) => const LoginScreen(),
              AppRoute.landing: (context) => const LandingScreen(),

              //Screens
              //Product Screen Route
              AppRoute.product: (context) => const ProductScreen(),
              AppRoute.product_detail: (context) => const ProductDetailScreen(),
              AppRoute.product_create: (context) => const ProductCreateScreen(),

              AppRoute.customer: (context) => const CustomerScreen(),

              AppRoute.order: (context) => const OrderScreen()
            },
          );
        },
      ),
    );
  }
}
