import 'package:json_annotation/json_annotation.dart';
part 'status_response.g.dart';

@JsonSerializable()
class ProductStatusResponse {
  String status;

  ProductStatusResponse({
    required this.status,
  });

  factory ProductStatusResponse.fromJson(Map<String, dynamic> json) =>
      ProductStatusResponse(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
