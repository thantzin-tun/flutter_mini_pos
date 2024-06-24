import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/landing/landing_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_demo/resources/colors.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    BlocProvider.of<LandingCubit>(context).landingBrain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LandingCubit, LandingState>(
      listener: (context, state) {
        if (state is LandingSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: KColor.PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
