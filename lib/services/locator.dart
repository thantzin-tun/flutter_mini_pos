import 'package:dio/dio.dart';
import 'package:flutter_bloc_demo/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:flutter_bloc_demo/features/customer/data/customerApi.dart';
import 'package:flutter_bloc_demo/features/customer/presentation/bloc/customer/customer_cubit.dart';
import 'package:flutter_bloc_demo/features/home/presentation/bloc/landing/landing_cubit.dart';
import 'package:flutter_bloc_demo/features/product/data/productApi.dart';
import 'package:flutter_bloc_demo/features/product/presentation/bloc/product/product_cubit.dart';
import 'package:flutter_bloc_demo/services/api_client.dart';
import 'package:flutter_bloc_demo/services/tokenInterceptor.dart';
import 'package:flutter_bloc_demo/services/token_store.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

GetIt getIt = GetIt.instance;

void locator() {
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor());
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90,
  )); // Add this code
  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton(() => ApiClient(getIt.call()));
  getIt.registerLazySingleton(() => ProductCubit(getIt.call()));
  getIt.registerLazySingleton(() => ProductRequestApi(getIt.call()));
  getIt.registerLazySingleton(() => CustomerRequestApi());
  getIt.registerLazySingleton(() => TokenStorePref);
  getIt.registerLazySingleton(() => LandingCubit());
  getIt.registerLazySingleton(() => CustomerCubit(getIt.call()));
  getIt.registerLazySingleton(() => LoginCubit());
}
