import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodItem foodItem;
  final Restaurant restaurant;

  const FoodDetailScreen({
    super.key,
    required this.foodItem,
    required this.restaurant,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int _quantity = 1;
  String? _selectedSize;
  final List<String> _selectedAddons = [];
  final TextEditingController _specialInstructionsController = TextEditingController();

  @override
  void dispose() {
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodItem.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                widget.foodItem.image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.foodItem.name,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(widget.foodItem.description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  '\$${widget.foodItem.discountedPrice.toStringAsFixed(2)}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (widget.foodItem.discount != null) ...[
                  const SizedBox(width: 10),
                  Text(
                    '\$${widget.foodItem.price.toStringAsFixed(2)}',
                    style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.redAccent, // Fixed styling
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${(widget.foodItem.discount! * 100).toInt()}% OFF',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
            if (widget.foodItem.sizes != null && widget.foodItem.sizes!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Choose Size', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: widget.foodItem.sizes!.map((size) {
                  return ChoiceChip(
                    label: Text(size),
                    selected: _selectedSize == size,
                    selectedColor: theme.primaryColor.withOpacity(0.2),
                    onSelected: (selected) {
                      setState(() {
                        _selectedSize = selected ? size : null;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            if (widget.foodItem.addons != null && widget.foodItem.addons!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text('Add Extras (+ \$0.50 each)', style: theme.textTheme.titleMedium),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: widget.foodItem.addons!.map((addon) {
                  return FilterChip(
                    label: Text(addon),
                    selected: _selectedAddons.contains(addon),
                    selectedColor: theme.primaryColor.withOpacity(0.2),
                    onSelected: (selected) {
                      setState(() {
                        selected ? _selectedAddons.add(addon) : _selectedAddons.remove(addon);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 24),
            Text('Special Instructions', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _specialInstructionsController,
              decoration: const InputDecoration(
                hintText: 'Any special requests?',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text('Quantity', style: theme.textTheme.titleMedium),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => setState(() => _quantity > 1 ? _quantity-- : _quantity),
                    ),
                    Text('$_quantity', style: theme.textTheme.titleLarge),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Total', style: TextStyle(color: Colors.grey)),
                  Text(
                    '\$${(widget.foodItem.discountedPrice * _quantity + _selectedAddons.length * 0.5 * _quantity).toStringAsFixed(2)}',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Add to Cart'),
                onPressed: () {
                  if (widget.foodItem.sizes != null &&
                      widget.foodItem.sizes!.isNotEmpty &&
                      _selectedSize == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a size')),
                    );
                    return;
                  }

                  final cartItem = CartItem(
                    foodItemId: widget.foodItem.id,
                    name: widget.foodItem.name,
                    image: widget.foodItem.image,
                    price: widget.foodItem.discountedPrice,
                    selectedSize: _selectedSize,
                    selectedAddons: List.from(_selectedAddons),
                    quantity: _quantity,
                    specialInstructions: _specialInstructionsController.text,
                  );

                  cartProvider.addToCart(cartItem, widget.restaurant);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}