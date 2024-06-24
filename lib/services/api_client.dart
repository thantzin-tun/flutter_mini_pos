import 'package:flutter_bloc_demo/constants/config.dart';
import 'package:flutter_bloc_demo/constants/endPoint.dart';

import 'package:flutter_bloc_demo/features/product/models/status_response.dart';
import 'package:flutter_bloc_demo/features/product/models/product_model.dart';

import 'package:retrofit/http.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(EndPoint.product)
  Future<Product> getProducts();

  @DELETE(EndPoint.delete_product)
  Future<HttpResponse> deleteProduct(@Path("id") int id);

  @POST(EndPoint.product_create)
  Future<ProductStatusResponse> addProduct(@Body() product);

  // @GET(EndPoint.customer)
  // Future<List<Customer>> getCustomer();

  // @GET(EndPoint.order)
  // Future<List<Order>> getOrder();

  // @DELETE(EndPoint.delete_product)
  // Future<StatusResponse> deleteProduct(@Path("id") int id);
}
