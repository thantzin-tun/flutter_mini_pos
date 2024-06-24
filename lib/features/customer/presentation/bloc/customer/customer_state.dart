part of 'customer_cubit.dart';

@immutable
sealed class CustomerState extends Equatable {
  const CustomerState();
}

final class CustomerInitial extends CustomerState {
  @override
  List<Object> get props => [];
}

final class CustomerFetchingProcessLoading extends CustomerState {
  @override
  List<Object> get props => [];
}

final class CustomerFetchingProcessSuccess extends CustomerState {
  final List<Product> products;
  const CustomerFetchingProcessSuccess({required this.products});
  @override
  List<Object> get props => [products];
}

final class CustomerFetchingProcessFailure extends CustomerState {
  final String errMessage;
  const CustomerFetchingProcessFailure({required this.errMessage});
  @override
  List<Object> get props => [];
}
