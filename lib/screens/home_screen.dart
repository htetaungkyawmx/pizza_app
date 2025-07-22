import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import 'food_menu_screen.dart';
import '../models/restaurant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurants = restaurantProvider.restaurants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Pizza App'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (ctx, index) {
          final restaurant = restaurants[index];
          return ListTile(
            leading: Image.asset(
              restaurant.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(restaurant.name),
            subtitle: Text(restaurant.description ?? ''),
            onTap: () {
              final foodItems = restaurantProvider.getFoodItemsByRestaurant(restaurant.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FoodMenuScreen(foodItems: foodItems, restaurant: restaurant),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
