import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza.dart';
import '../providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final Pizza pizza;

  CartItemWidget({required this.pizza});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return ListTile(
      leading: Image.network(pizza.image, width: 50),
      title: Text(pizza.name),
      subtitle: Text('\$${pizza.price}'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => cart.removeItem(pizza),
      ),
    );
  }
}
