import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../screens/pizza_detail_screen.dart';

class PizzaCard extends StatelessWidget {
  final Pizza pizza;

  const PizzaCard({Key? key, required this.pizza}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        shadowColor: Colors.black.withOpacity(0.2),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PizzaDetailScreen(pizza: pizza)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Image with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    pizza.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pizza.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Optional description or some subtitle
                      if (pizza.description != null && pizza.description!.isNotEmpty)
                        Text(
                          pizza.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(height: 8),
                      // Price container
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${pizza.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
