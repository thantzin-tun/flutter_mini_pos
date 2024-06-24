part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final Product products;
  const ProductSuccess(this.products);
  @override
  List<Object> get props => [products];
}

final class ProductDeleteSuccess extends ProductState {}

final class ProductCreateSuccess extends ProductState {}

final class ProductFailed extends ProductState {
  final String errorMessage;
  const ProductFailed(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
