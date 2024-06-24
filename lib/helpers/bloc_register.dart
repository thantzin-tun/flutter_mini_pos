import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:flutter_bloc_demo/features/customer/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/landing/landing_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc_demo/features/order/presentation/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_demo/features/product/presentation/bloc/product/product_cubit.dart';
import 'package:flutter_bloc_demo/services/locator.dart';

class BlocRegister extends StatelessWidget {
  final Widget child;
  const BlocRegister({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProductCubit>(
        create: (_) => ProductCubit(getIt.call()),
      ),
      BlocProvider<LandingCubit>(
        create: (_) => LandingCubit(),
      ),
      BlocProvider<CustomerCubit>(
        create: (_) => CustomerCubit(getIt.call()),
      ),
      BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(),
      ),
      BlocProvider<CounterBloc>(
        create: (_) => CounterBloc(),
      ),
      BlocProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
      ),
    ], child: child);
  }
}
