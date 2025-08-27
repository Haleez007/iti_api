abstract class AddToCartState {}

class CartInitial extends AddToCartState {}

class CartLoading extends AddToCartState {}

class CartState extends AddToCartState {
  final List<dynamic> cartItems;

  CartState({required this.cartItems});
}