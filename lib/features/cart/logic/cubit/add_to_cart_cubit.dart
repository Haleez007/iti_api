import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(CartState(cartItems: []));

  void addToCart(Map<String, dynamic> product) {
    final currentState = state as CartState;
    emit(CartState(cartItems: [...currentState.cartItems, product]));
  }

  void removeItemFromCart(Map<String, dynamic> product) {
    final currentState = state as CartState;
    final updatedItems = List<Map<String, dynamic>>.from(currentState.cartItems)
      ..removeWhere((item) => item['id'] == product['id']);
    emit(CartState(cartItems: updatedItems));
  }

  void clearItemsFromCart() {
    emit(CartState(cartItems: []));
  }
}