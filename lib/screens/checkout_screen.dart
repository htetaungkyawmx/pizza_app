import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your order of \$${cart.totalPrice.toStringAsFixed(2)} is placed!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Back to Home'),
            )
          ],
        ),
      ),
    );
  }
}
