import 'package:flutter/material.dart';
import '../models/pizza.dart';

class CartProvider with ChangeNotifier {
  final List<Pizza> _items = [];

  List<Pizza> get items => _items;

  void addItem(Pizza pizza) {
    _items.add(pizza);
    notifyListeners();
  }

  void removeItem(Pizza pizza) {
    _items.remove(pizza);
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
