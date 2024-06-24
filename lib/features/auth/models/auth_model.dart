import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String username;
  final String password;

  LoginModel({
    required this.username,
    required this.password,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class AuthResponse {
  String token;
  User? user;
  String message;

  AuthResponse({
    required this.token,
    required this.user,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        token: json["token"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
        "message": message,
      };
}

@JsonSerializable()
class User {
  int id;
  String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
