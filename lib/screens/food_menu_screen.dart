import 'package:flutter/material.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import 'food_detail_screen.dart';
import '../widgets/food_card.dart';

class FoodMenuScreen extends StatelessWidget {
  final List<FoodItem> foodItems;
  final Restaurant restaurant;

  const FoodMenuScreen({super.key, required this.foodItems, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (ctx, index) {
          final foodItem = foodItems[index];
          return FoodCard(
            name: foodItem.name,
            price: foodItem.discountedPrice,
            image: foodItem.image,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FoodDetailScreen(foodItem: foodItem, restaurant: restaurant),
                ),
              );
            }, fallbackImage: '',
          );
        },
      ),
    );
  }
}
