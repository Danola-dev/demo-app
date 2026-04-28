import 'package:demo_app/models/shoes.dart';
import 'package:flutter_riverpod/legacy.dart';

class CartNotifier extends StateNotifier<List<Shoes>> {
  CartNotifier() : super([]);

  void addItem(Shoes shoe) {
    state = [...state, shoe];
  }

  void removeItem(Shoes shoe) {
    state = state.where((item) => item != shoe).toList();
  }

  int get totalPrice {
    return state.fold(0, (sum, item) {
      return sum + item.price;
    });
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<Shoes>>((ref) {
  return CartNotifier();
});
