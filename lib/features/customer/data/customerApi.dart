// ignore: file_names
import 'dart:convert';
import 'package:flutter_bloc_demo/features/customer/models/product.dart';
import 'package:http/http.dart' as http;

class CustomerRequestApi {
  Future<List<Product>?> getCustomer() async {
    try {
      var url = Uri.parse('https://fakestoreapi.com/products');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Product> products =
            jsonResponse.map((data) => Product.fromJson(data)).toList();
        print(products);
        return products;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
