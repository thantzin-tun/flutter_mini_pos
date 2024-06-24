import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/features/customer/data/customerApi.dart';
import 'package:flutter_bloc_demo/features/customer/models/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRequestApi _apiClient;
  CustomerCubit(this._apiClient) : super(CustomerInitial()) {
    fetchProduct();
  }

  List<Product>? products;

  Future fetchProduct() async {
    emit(CustomerFetchingProcessLoading());
    try {
      products = await _apiClient.getCustomer();
      print("Product are");
      print(products);
      emit(CustomerFetchingProcessSuccess(products: products!));
    } catch (e) {
      emit(CustomerFetchingProcessFailure(errMessage: e.toString()));
    }
  }
}
