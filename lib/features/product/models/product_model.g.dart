// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int,
      pages: json['pages'] as int,
      nextPage: json['nextPage'],
      previousPage: json['previousPage'],
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'products': instance.products,
      'count': instance.count,
      'pages': instance.pages,
      'nextPage': instance.nextPage,
      'previousPage': instance.previousPage,
    };

ProductElement _$ProductElementFromJson(Map<String, dynamic> json) =>
    ProductElement(
      id: json['id'] as int,
      name: json['name'] as String,
      pricePerUnit: json['pricePerUnit'] as String,
      unit: json['unit'] as String,
      description: json['description'] as String?,
      stock: json['stock'] as String,
      productImage: json['productImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ProductElementToJson(ProductElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pricePerUnit': instance.pricePerUnit,
      'unit': instance.unit,
      'description': instance.description,
      'stock': instance.stock,
      'productImage': instance.productImage,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
