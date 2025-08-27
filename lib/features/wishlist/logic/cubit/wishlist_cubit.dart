import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistInitial()) {
    emit(const WishlistLoaded([]));
  }

  List<Map<String, dynamic>> get _items => state is WishlistLoaded
      ? List<Map<String, dynamic>>.from((state as WishlistLoaded).items)
      : <Map<String, dynamic>>[];

  void add(Map<String, dynamic> product) {
    final items = _items;
    final id = product['id']?.toString();
    if (id == null) return;
    if (!items.any((e) => e['id'].toString() == id)) {
      items.add(product);
      emit(WishlistLoaded(items));
    }
  }

  void removeById(dynamic id) {
    final items = _items;
    items.removeWhere((e) => e['id'].toString() == id.toString());
    emit(WishlistLoaded(items));
  }

  void toggle(Map<String, dynamic> product) {
    final id = product['id']?.toString();
    if (id == null) return;
    if (isInWishlist(id)) {
      removeById(id);
    } else {
      add(product);
    }
  }

  bool isInWishlist(dynamic id) {
    return _items.any((e) => e['id'].toString() == id.toString());
  }

  void clear() {
    emit(const WishlistLoaded([]));
  }
}
