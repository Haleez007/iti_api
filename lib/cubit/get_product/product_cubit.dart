import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iti_api/cubit/get_product/product_state.dart';
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
          var responseBody = json.decode(response.body);
          // print('responseBody $responseBody');
          List products = responseBody['products'];
          emit(SuccessProductState(product: products));
        }
      } catch (e) {
        emit(ErrorProductState(error: 'Error ${e.toString()}'));
      }
    }
  }
