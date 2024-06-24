import 'package:flutter_bloc_demo/features/product/models/product_model.dart';
import 'package:flutter_bloc_demo/features/product/models/status_response.dart';
import 'package:flutter_bloc_demo/services/api_client.dart';
import 'package:retrofit/dio.dart';

class ProductRequestApi {
  final ApiClient _apiClient;

  ProductRequestApi(this._apiClient);

  Future<Product?> getProduct() async {
    try {
      Product products = await _apiClient.getProducts();
      return products;
    } catch (e) {
      return null;
    }
  }

  Future<HttpResponse> deleteProduct(int id) async {
    try {
      var response = await _apiClient.deleteProduct(id);
      return response;
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  Future<ProductStatusResponse> addProduct(product) async {
    try {
      ProductStatusResponse response = await _apiClient.addProduct(product);
      return response;
    } catch (e) {
      throw Exception('Failed to Create product: $e');
    }
  }
}
