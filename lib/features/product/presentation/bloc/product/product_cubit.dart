import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_demo/features/product/data/productApi.dart';
import 'package:flutter_bloc_demo/features/product/models/create_product_model.dart';
import 'package:flutter_bloc_demo/features/product/models/product_model.dart';
import 'package:flutter_bloc_demo/features/product/models/status_response.dart';
import 'package:flutter_bloc_demo/helpers/loggin.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRequestApi _apiClient;
  ProductCubit(this._apiClient) : super(ProductInitial());

  Product? products;

  Future fetchProduct() async {
    emit(ProductLoading());
    try {
      products = await _apiClient.getProduct();
      emit(ProductSuccess(products!));
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  Future deleteProduct(int? id) async {
    emit(ProductLoading());
    try {
      var response = await _apiClient.deleteProduct(id!);
      if (response.response.statusCode == 200) {
        // final index =
        //     products?.products.indexWhere((product) => product.id == id);
        // if (index != null && index >= 0) {
        //   products!.products.removeAt(index);
        //   emit(ProductSuccess(products!));
        // }
        emit(ProductDeleteSuccess());
      }
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }

  Future addProduct(CreateProductElement product) async {
    emit(ProductLoading());
    try {
      String? fileName = product.productImage?.substring(
          product.productImage!.lastIndexOf("/") + 1,
          product.productImage!.toString().length);
      var formData = product.productImage != null
          ? FormData.fromMap({
              'product_image': await MultipartFile.fromFile(
                  product.productImage.toString(),
                  filename: fileName),
              'name': product.name,
              'price_per_unit': product.pricePerUnit,
              'unit': product.unit,
              'description': product.description,
              'stock': product.stock,
            })
          : FormData.fromMap({
              'name': product.name,
              'price_per_unit': product.pricePerUnit,
              'unit': product.unit,
              'description': product.description,
              'stock': product.stock,
            });

      ProductStatusResponse response = await _apiClient.addProduct(formData);

      if (response.status == "success") {
        // products?.products.add(response.product);
        // emit(ProductSuccess(products!));
        logger("Response", response.status);
        emit(ProductCreateSuccess());
      } else {
        logger("Response", response.status);
        emit(const ProductFailed("တစ်ခုခုမှားယွင်းနေပါသည်"));
      }
    } catch (e) {
      emit(ProductFailed(e.toString()));
    }
  }
}
