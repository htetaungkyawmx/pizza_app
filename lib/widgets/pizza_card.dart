import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../screens/pizza_detail_screen.dart';

class PizzaCard extends StatelessWidget {
  final Pizza pizza;

  PizzaCard({required this.pizza});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 3,
      child: ListTile(
        leading: Image.asset(pizza.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(pizza.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('\$${pizza.price.toStringAsFixed(2)}'),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PizzaDetailScreen(pizza: pizza)),
          );
        },
      ),
    );
  }
}
