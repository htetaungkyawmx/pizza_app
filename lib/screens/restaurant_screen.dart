import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../providers/cart_provider.dart';
import '../services/api_service.dart';
import '../widgets/food_card.dart';
import 'food_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return Scaffold(
      appBar: AppBar(title: Text(restaurant.name)),
      body: FutureBuilder<List<FoodItem>>(
        future: apiService.getFoodItemsByRestaurant(restaurant.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items available'));
          }
          final foodItems = snapshot.data!;
          return ListView.builder(
            itemCount: foodItems.length,
            itemBuilder: (ctx, index) => FoodCard(
              name: foodItems[index].name,
              price: foodItems[index].discountedPrice,
              image: foodItems[index].image,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodDetailScreen(
                      foodItem: foodItems[index],
                      restaurant: restaurant,
                    ),
                  ),
                );
              }, fallbackImage: '',
            ),
          );
        },
      ),
    );
  }
}