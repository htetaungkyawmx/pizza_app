import 'dart:async';

import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  double _totalDiscount = 0;

  List<CartItem> get items => _items;
  double get totalDiscount => _totalDiscount;

  Future<Restaurant?> get restaurant async {
    if (_items.isEmpty) return null;
    // Assume cart items are from one restaurant for simplicity
    final apiService = ApiService();
    final restaurants = await apiService.getRestaurants();
    return restaurants.firstWhere(
          (r) => r.id == _items.first.restaurantId,
      orElse: () => Restaurant(
        id: '',
        name: 'Unknown',
        image: 'assets/images/placeholder.png',
        rating: 0,
        deliveryTime: '',
        deliveryFee: 0,
        minOrder: 0,
        tags: [],
        discount: 0,
      ),
    );
  }

  Future<double> get subtotal async => _items.fold(0, (sum, item) => sum + item.totalPrice * item.quantity);

  Future<double> get deliveryFee async {
    if (_items.isEmpty) return 0;
    final apiService = ApiService();
    final restaurants = await apiService.getRestaurants();
    final restaurant = restaurants.firstWhere(
          (r) => r.id == _items.first.restaurantId,
      orElse: () => Restaurant(
        id: '',
        name: 'Unknown',
        image: 'assets/images/placeholder.png',
        rating: 0,
        deliveryTime: '',
        deliveryFee: 0,
        minOrder: 0,
        tags: [],
        discount: 0,
      ),
    );
    return restaurant.deliveryFee;
  }

  Future<double> get total async {
    final sub = await subtotal;
    final fee = await deliveryFee;
    return sub * (1 - _totalDiscount / 100) + fee;
  }

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((i) => i.id == item.id && i.selectedSize == item.selectedSize);
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _updateDiscount();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _updateDiscount();
    notifyListeners();
  }

  void updateQuantity(String id, int newQuantity) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = newQuantity;
      if (_items[itemIndex].quantity <= 0) {
        _items.removeAt(itemIndex);
      }
      _updateDiscount();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _totalDiscount = 0;
    notifyListeners();
  }

  void _updateDiscount() {
    _totalDiscount = _items.length > 2 ? 10 : 0;
  }

  Future<void> placeOrder() async {
    final apiService = ApiService();
    await apiService.placeOrder({
      'items': _items.map((item) => {
        'id': item.id,
        'name': item.name,
        'quantity': item.quantity,
        'price': item.totalPrice,
        'size': item.selectedSize,
        'addons': item.selectedAddons,
      }).toList(),
      'total': await total,
    });
    clearCart();
  }
}

extension on FutureOr<double> {
  FutureOr<double> operator +(double other) {
    return other;
  }
}