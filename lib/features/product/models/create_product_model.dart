import 'package:json_annotation/json_annotation.dart';

part 'create_product_model.g.dart';

@JsonSerializable()
class CreateProductElement {
  String name;
  String pricePerUnit;
  String unit;
  String? description;
  String stock;
  String? productImage;

  CreateProductElement({
    required this.name,
    required this.pricePerUnit,
    required this.unit,
    this.description,
    required this.stock,
    this.productImage,
  });

  factory CreateProductElement.fromJson(Map<String, dynamic> json) =>
      CreateProductElement(
        name: json["name"],
        pricePerUnit: json["price_per_unit"],
        unit: json["unit"],
        description: json["description"],
        stock: json["stock"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price_per_unit": pricePerUnit,
        "unit": unit,
        "description": description,
        "stock": stock,
        "product_image": productImage,
      };
}
