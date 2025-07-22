import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pizza.dart';
import '../providers/cart_provider.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;

  PizzaDetailScreen({required this.pizza});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final List<String> meats = ['Chicken', 'Beef', 'Bacon'];
  final List<String> vegetables = ['Mushroom', 'Olives', 'Capsicum'];

  List<String> selectedMeats = [];
  List<String> selectedVegetables = [];

  bool applyDiscount = false;

  double get totalPrice {
    double base = widget.pizza.price;
    double extras = (selectedMeats.length + selectedVegetables.length) * 1.5;
    double total = base + extras;
    if (applyDiscount) total *= 0.9; // 10% discount
    return total;
  }

  void toggleMeat(String meat) {
    setState(() {
      selectedMeats.contains(meat)
          ? selectedMeats.remove(meat)
          : selectedMeats.add(meat);
    });
  }

  void toggleVegetable(String veg) {
    setState(() {
      selectedVegetables.contains(veg)
          ? selectedVegetables.remove(veg)
          : selectedVegetables.add(veg);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.pizza.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(widget.pizza.image, width: 250, height: 250),
            SizedBox(height: 10),
            Text(
              widget.pizza.description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Divider(height: 30),
            Text('Choose Meats', style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: meats.map((meat) {
                return FilterChip(
                  label: Text(meat),
                  selected: selectedMeats.contains(meat),
                  onSelected: (_) => toggleMeat(meat),
                );
              }).toList(),
            ),
            SizedBox(height: 15),
            Text('Choose Vegetables',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: vegetables.map((veg) {
                return FilterChip(
                  label: Text(veg),
                  selected: selectedVegetables.contains(veg),
                  onSelected: (_) => toggleVegetable(veg),
                );
              }).toList(),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: applyDiscount,
                  onChanged: (val) {
                    setState(() {
                      applyDiscount = val ?? false;
                    });
                  },
                ),
                Text('Apply 10% discount'),
              ],
            ),
            Spacer(),
            Text('Total: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                cart.addItem(widget.pizza); // You can enhance this to include options
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to cart!')),
                );
              },
              icon: Icon(Icons.add_shopping_cart),
              label: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
