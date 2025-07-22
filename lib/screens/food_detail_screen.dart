import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem foodItem;
  final Restaurant restaurant;

  const FoodDetailScreen({required this.foodItem, required this.restaurant});

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  String? _selectedSize;
  List<String> _selectedAddons = [];
  final TextEditingController _instructionsController = TextEditingController();
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.foodItem.sizes.isNotEmpty ? widget.foodItem.sizes[0] : null;
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text(widget.foodItem.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.foodItem.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.foodItem.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.foodItem.description ?? 'No description',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.foodItem.discountedPrice.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                  ),
                  if (widget.foodItem.discount > 0)
                    Text(
                      '(${widget.foodItem.discount * 100}% OFF)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  const SizedBox(height: 16),
                  if (widget.foodItem.sizes.isNotEmpty) ...[
                    const Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButton<String>(
                      value: _selectedSize,
                      items: widget.foodItem.sizes
                          .map((size) => DropdownMenuItem(value: size, child: Text(size)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSize = value;
                        });
                      },
                    ),
                  ],
                  if (widget.foodItem.addons.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text('Add-ons', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...widget.foodItem.addons.map((addon) => CheckboxListTile(
                      title: Text(addon),
                      value: _selectedAddons.contains(addon),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedAddons.add(addon);
                          } else {
                            _selectedAddons.remove(addon);
                          }
                        });
                      },
                    )),
                  ],
                  const SizedBox(height: 16),
                  const Text('Special Instructions', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _instructionsController,
                    decoration: const InputDecoration(
                      hintText: 'E.g., No onions',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_quantity > 1) setState(() => _quantity--);
                        },
                      ),
                      Text('$_quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => _quantity++),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      cartProvider.addItem(CartItem(
                        id: widget.foodItem.id,
                        name: widget.foodItem.name,
                        price: widget.foodItem.discountedPrice,
                        image: widget.foodItem.image,
                        quantity: _quantity,
                        selectedSize: _selectedSize,
                        selectedAddons: _selectedAddons,
                        specialInstructions: _instructionsController.text, restaurantId: '',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${widget.foodItem.name} added to cart')),
                      );
                    },
                    child: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}