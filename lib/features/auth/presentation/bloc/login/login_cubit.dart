import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/constants/config.dart';
import 'package:flutter_bloc_demo/features/auth/models/auth_model.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';
import 'package:flutter_bloc_demo/services/token_store.dart';
import 'package:http/http.dart' as http;
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<AuthResponse?> signIn(username, password) async {
    emit(LoginLoading());
    try {
      var url = Uri.parse('$baseUrl/signin');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'}, // Set the content type
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      AuthResponse jsonResponse =
          AuthResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        await TokenStorePref.setToken(jsonResponse.token);
        emit(LoginSuccess(jsonResponse));
        return jsonResponse;
      } else {
        logger("Response failed", jsonResponse.message);
        if (jsonResponse.message == "pass") {
          emit(const LoginFailed(message: "လျှိဝှက်နံပါတ်မှားယွင်းနေပါသည်"));
        } else {
          emit(const LoginFailed(message: "သင့်ဧ။်အကောင့်ကို ရှာမတွေ့ပါ"));
        }
        return null;
      }
    } catch (e) {
      emit(LoginFailed(message: e.toString()));
      return null;
    }
  }
}
