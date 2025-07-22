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
    required this.id,
    required this.foodItemId,
    required this.name,
    required this.image,
    required this.price,
    this.selectedSize,
    this.selectedAddons = const [],
    required this.quantity,
    this.specialInstructions = '',
  });

  double get totalPrice {
    // Assuming each addon adds $0.50
    double addonCost = selectedAddons.length * 0.5;
    return (price + addonCost) * quantity;
  }
}
