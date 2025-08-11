import 'food_type.dart';

class FoodItem {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String image;
  final FoodType type;
  final String restaurantId;
  final List<String> sizes;
  final List<String> addons;
  final bool isVeg;
  final double discount;

  FoodItem({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.image,
    required this.type,
    required this.restaurantId,
    required this.sizes,
    required this.addons,
    required this.isVeg,
    this.discount = 0,
  });

  double get discountedPrice => price * (1 - discount / 100);
}
