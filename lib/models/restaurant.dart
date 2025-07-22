class Restaurant {
  final String id;
  final String name;
  final String? description;
  final String image;
  final double rating;
  final String deliveryTime;
  final double deliveryFee;
  final double minOrder;
  final List<String> tags;

  Restaurant({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minOrder,
    required this.tags,
  });
}
