import 'package:flutter/material.dart';
import 'package:pizza_app/models/cart_item.dart';
import 'package:pizza_app/models/restaurant.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';
import '../models/order.dart';
import '../services/location_service.dart';
import 'order_status_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key, required Restaurant restaurant, required List<CartItem> items, required double subtotal, required double deliveryFee, required double total});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String _paymentMethod = 'Cash on Delivery';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _addressController.text = userProvider.address ?? '';
    _phoneController.text = userProvider.phone ?? '';
    _prefillAddress();
  }

  Future<void> _prefillAddress() async {
    try {
      final locationService = LocationService();
      final position = await locationService.getCurrentLocation();
      final address = await locationService.getAddressFromCoordinates(position.latitude, position.longitude);
      _addressController.text = address;
    } catch (e) {
      // Ignore errors for now, keep user-provided address
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final restaurant = cartProvider.restaurant;
    final items = cartProvider.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery Address', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  hintText: 'Enter delivery address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a delivery address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Phone Number', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Payment Method', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                onChanged: (value) => setState(() => _paymentMethod = value!),
                items: ['Cash on Delivery', 'Credit Card', 'PayPal']
                    .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              Text('Order Summary', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              ...items.map((item) => ListTile(
                title: Text(item.name),
                subtitle: Text(
                  'Quantity: ${item.quantity} ${item.selectedSize != null ? "(${item.selectedSize})" : ""}',
                ),
                trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
              )),
              const Divider(),
              ListTile(
                title: const Text('Subtotal'),
                trailing: Text('\$${cartProvider.subtotal.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Delivery Fee'),
                trailing: Text('\$${cartProvider.deliveryFee.toStringAsFixed(2)}'),
              ),
              ListTile(
                title: const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Text(
                  '\$${cartProvider.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    if (!_formKey.currentState!.validate()) return;
                    setState(() => _isLoading = true);
                    try {
                      final orderId = DateTime.now().toIso8601String(); // TODO: Replace with UUID
                      userProvider.updateProfile(
                        phone: _phoneController.text,
                        address: _addressController.text,
                      );
                      final order = Order(
                        id: orderId,
                        userId: userProvider.userId ?? 'guest',
                        restaurantId: restaurant!.id,
                        restaurantName: restaurant.name,
                        items: items,
                        orderTime: DateTime.now(),
                        subtotal: cartProvider.subtotal,
                        deliveryFee: cartProvider.deliveryFee,
                        total: cartProvider.total,
                        deliveryAddress: _addressController.text,
                        paymentMethod: _paymentMethod,
                      );
                      // Simulate order placement
                      await Future.delayed(const Duration(seconds: 1));
                      cartProvider.clearCart();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderStatusScreen(orderId: orderId),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error placing order: $e')),
                      );
                    } finally {
                      setState(() => _isLoading = false);
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Place Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}