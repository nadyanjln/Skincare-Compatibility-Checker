import 'package:capstone/data/model/product_response.dart';

sealed class ProductResultState {}

class ProductNoneState extends ProductResultState {}

class ProductLoadingState extends ProductResultState {}

class ProductErrorState extends ProductResultState {
  final String error;

  ProductErrorState(this.error);
}

class ProductLoadedState extends ProductResultState {
  final List<Product> data;

  ProductLoadedState(this.data);
}
