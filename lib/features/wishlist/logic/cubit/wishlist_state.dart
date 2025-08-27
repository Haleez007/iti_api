abstract class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  const WishlistInitial();
}

class WishlistLoaded extends WishlistState {
  final List<Map<String, dynamic>> items;
  const WishlistLoaded(this.items);
}
