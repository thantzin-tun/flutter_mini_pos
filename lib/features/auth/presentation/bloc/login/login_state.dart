part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final AuthResponse response;
  const LoginSuccess(this.response);
  @override
  List<Object> get props => [response];
}

final class LoginFailed extends LoginState {
  final String message;
  const LoginFailed({required this.message});
}
