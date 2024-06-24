import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  List<ProductElement> products;
  int count;
  int pages;
  dynamic nextPage;
  dynamic previousPage;

  Product({
    required this.products,
    required this.count,
    required this.pages,
    required this.nextPage,
    required this.previousPage,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
        count: json["count"],
        pages: json["pages"],
        nextPage: json["next_page"],
        previousPage: json["previous_page"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "count": count,
        "pages": pages,
        "next_page": nextPage,
        "previous_page": previousPage,
      };
}

@JsonSerializable()
class ProductElement {
  int id;
  String name;
  String pricePerUnit;
  String unit;
  String? description;
  String stock;
  String? productImage;
  DateTime createdAt;
  DateTime updatedAt;

  ProductElement({
    required this.id,
    required this.name,
    required this.pricePerUnit,
    required this.unit,
    this.description,
    required this.stock,
    this.productImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        name: json["name"],
        pricePerUnit: json["price_per_unit"],
        unit: json["unit"],
        description: json["description"],
        stock: json["stock"],
        productImage: json["product_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price_per_unit": pricePerUnit,
        "unit": unit,
        "description": description,
        "stock": stock,
        "product_image": productImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
