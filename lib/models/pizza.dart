class Pizza {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  int quantity;  // <-- Add this, make mutable to update quantity

  Pizza({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1, // default 1
  });
}
