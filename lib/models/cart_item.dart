class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;
  final String? selectedSize;
  final List<String> selectedAddons;
  final String specialInstructions;
  final String restaurantId;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
    this.selectedSize,
    this.selectedAddons = const [],
    this.specialInstructions = '',
    required this.restaurantId,
  });

  double get totalPrice => price * quantity;
}