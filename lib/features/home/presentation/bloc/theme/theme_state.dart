part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {
  final String mode;
  const ThemeInitial(this.mode);
  @override
  List<Object> get props => [mode];
}

final class ThemeChanged extends ThemeState {
  final String mode;
  const ThemeChanged(this.mode);

  @override
  List<Object> get props => [mode];
}
