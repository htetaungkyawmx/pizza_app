import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String foodItemId;
  final String name;
  final String image;
  final double price;
  final String? selectedSize;
  final List<String> selectedAddons;
  final int quantity;
  final String specialInstructions;

  CartItem({
    String? id,
    required this.foodItemId,
    required this.name,
    required this.image,
    required this.price,
    this.selectedSize,
    this.selectedAddons = const [],
    required this.quantity,
    this.specialInstructions = '',
  }) : id = id ?? const Uuid().v4();

  double get totalPrice {
    double addonCost = selectedAddons.length * 0.5;
    return (price + addonCost) * quantity;
  }
}