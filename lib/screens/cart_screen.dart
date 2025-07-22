import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_card.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          if (cartProvider.restaurant != null)
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(cartProvider.restaurant!.name),
              subtitle: Text(cartProvider.restaurant!.deliveryTime),
            ),
          Expanded(
            child: cartProvider.items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (ctx, index) {
                final item = cartProvider.items[index];
                return CartItemCard(
                  item: item,
                  onRemove: () => cartProvider.removeFromCart(item.id),
                  onQuantityChanged: (newQuantity) {
                    cartProvider.updateQuantity(item.id, newQuantity);
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('\$${cartProvider.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Fee'),
                    Text('\$${cartProvider.deliveryFee.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      '\$${cartProvider.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartProvider.items.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(
                            restaurant: cartProvider.restaurant!,
                            items: cartProvider.items,
                            subtotal: cartProvider.subtotal,
                            deliveryFee: cartProvider.deliveryFee,
                            total: cartProvider.total,
                          ),
                        ),
                      );
                    },
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
