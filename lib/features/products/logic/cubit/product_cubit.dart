import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iti_api/features/products/logic/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> getProduct() async {
    emit(LoadingProductState());
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final List products = responseBody['products'] as List;
        emit(SuccessProductState(product: products));
      } else {
        emit(ErrorProductState(error: 'Server error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ErrorProductState(error: 'Error ${e.toString()}'));
    }
  }
}
