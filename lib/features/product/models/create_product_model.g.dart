// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductElement _$CreateProductElementFromJson(
        Map<String, dynamic> json) =>
    CreateProductElement(
      name: json['name'] as String,
      pricePerUnit: json['pricePerUnit'] as String,
      unit: json['unit'] as String,
      description: json['description'] as String?,
      stock: json['stock'] as String,
      productImage: json['productImage'] as String?,
    );

Map<String, dynamic> _$CreateProductElementToJson(
        CreateProductElement instance) =>
    <String, dynamic>{
      'name': instance.name,
      'pricePerUnit': instance.pricePerUnit,
      'unit': instance.unit,
      'description': instance.description,
      'stock': instance.stock,
      'productImage': instance.productImage,
    };
