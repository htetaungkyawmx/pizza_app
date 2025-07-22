import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import 'food_menu_screen.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final foodItems = restaurantProvider.getFoodItemsByRestaurant(restaurant.id);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Menu'),
              Tab(text: 'Info'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FoodMenuScreen(
              foodItems: foodItems,
              restaurant: restaurant,
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(restaurant.description ?? 'No description available.'),
                  const SizedBox(height: 16),
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.timer),
                    title: const Text('Delivery Time'),
                    subtitle: Text(restaurant.deliveryTime),
                  ),
                  ListTile(
                    leading: const Icon(Icons.delivery_dining),
                    title: const Text('Delivery Fee'),
                    subtitle: Text('\$${restaurant.deliveryFee.toStringAsFixed(2)}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: const Text('Minimum Order'),
                    subtitle: Text('\$${restaurant.minOrder.toStringAsFixed(2)}'),
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
