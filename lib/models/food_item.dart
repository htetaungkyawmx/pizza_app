enum FoodType { pizza, burger, snack, drink, dessert, asian, other }

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final FoodType type;
  final String restaurantId;
  final List<String>? tags;
  final List<String>? addons;
  final List<String>? sizes;
  final double? discount;
  final bool isVeg;
  final bool isSpicy;
  final int? preparationTime;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.type,
    required this.restaurantId,
    this.tags,
    this.addons,
    this.sizes,
    this.discount,
    this.isVeg = false,
    this.isSpicy = false,
    this.preparationTime,
  });

  double get discountedPrice => discount != null ? price * (1 - discount!) : price;
}
