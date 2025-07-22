import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final VoidCallback? onTap;

  const FoodCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: ListTile(
                title: Text(name),
                subtitle: Text('\$${price.toStringAsFixed(2)}'),
                trailing: const Icon(Icons.add_shopping_cart),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
