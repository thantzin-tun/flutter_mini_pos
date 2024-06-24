import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/services/store.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial("light")) {
    on<LightModeEvent>(_lightModeChange);
    on<DarkModeEvent>(_darkModeChange);
    _loadInitialMode();
  }

  Future<void> _loadInitialMode() async {
    final mode = await StoreSharePreferences.getStoreValueFunc('mode');
    if (mode == 'dark') {
      emit(const ThemeChanged("dark"));
    } else {
      emit(const ThemeChanged("light"));
    }
  }

  FutureOr<void> _lightModeChange(
      LightModeEvent event, Emitter<ThemeState> emit) async {
    await StoreSharePreferences.setStoreValueFunc('mode', 'light');
    emit(const ThemeChanged("light"));
  }

  FutureOr<void> _darkModeChange(
      DarkModeEvent event, Emitter<ThemeState> emit) async {
    await StoreSharePreferences.setStoreValueFunc('mode', 'dark');
    emit(const ThemeChanged("dark"));
  }
}
