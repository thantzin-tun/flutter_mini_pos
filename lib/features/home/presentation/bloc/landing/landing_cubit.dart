import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';
import 'package:flutter_bloc_demo/services/token_store.dart';
import 'package:meta/meta.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingInitial());

  Future landingBrain() async {
    emit(LandingLoading());

    String? hasToken = await TokenStorePref.getToken();

    logger("Token", hasToken);

    if (hasToken == null) {
      emit(LandingFailed());
    } else {
      emit(LandingSuccess());
    }
  }
}
