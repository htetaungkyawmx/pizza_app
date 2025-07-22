import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/restaurant.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Restaurant? _restaurant;

  Restaurant? get restaurant => _restaurant;

  List<CartItem> get items => _items.values.toList();

  double get subtotal {
    double total = 0;
    for (var item in _items.values) {
      total += item.totalPrice;
    }
    return total;
  }

  double get deliveryFee {
    return _restaurant?.deliveryFee ?? 0;
  }

  double get total => subtotal + deliveryFee;

  void addToCart(CartItem item, Restaurant restaurant) {
    // Enforce single restaurant per cart
    if (_restaurant != null && _restaurant!.id != restaurant.id) {
      clearCart();
    }
    _restaurant = restaurant;

    if (_items.containsKey(item.id)) {
      // Update quantity if item exists
      final existingItem = _items[item.id]!;
      _items[item.id] = CartItem(
        id: existingItem.id,
        foodItemId: existingItem.foodItemId,
        name: existingItem.name,
        image: existingItem.image,
        price: existingItem.price,
        selectedSize: existingItem.selectedSize,
        selectedAddons: existingItem.selectedAddons,
        quantity: existingItem.quantity + item.quantity,
        specialInstructions: existingItem.specialInstructions,
      );
    } else {
      _items[item.id] = item;
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.remove(id);
    if (_items.isEmpty) {
      _restaurant = null;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _restaurant = null;
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    if (!_items.containsKey(id)) return;
    if (quantity <= 0) {
      removeFromCart(id);
      return;
    }
    final item = _items[id]!;
    _items[id] = CartItem(
      id: item.id,
      foodItemId: item.foodItemId,
      name: item.name,
      image: item.image,
      price: item.price,
      selectedSize: item.selectedSize,
      selectedAddons: item.selectedAddons,
      quantity: quantity,
      specialInstructions: item.specialInstructions,
    );
    notifyListeners();
  }
}
