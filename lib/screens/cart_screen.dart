import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: cart.items.isEmpty
          ? Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return CartItemWidget(pizza: cart.items[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (_) => CheckoutScreen()));
                  },
                  child: Text('Checkout'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
