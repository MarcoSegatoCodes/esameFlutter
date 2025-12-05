import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:esame_flutter/models/product.dart';

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addItem(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      state[index].quantity++;
    } else {
      state = [...state, CartItem(product: product)];
    }
    state = [...state];
  }

  void incrementItem(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      state[index].quantity++;
      state = [...state];
    }
  }

  void decrementItem(String productId) {
    final index = state.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      state[index].quantity > 1
          ? state[index].quantity--
          : state.removeAt(index);
      state = [...state];
    }
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});
