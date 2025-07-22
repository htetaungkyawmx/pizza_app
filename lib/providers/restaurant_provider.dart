import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];

  List<Restaurant> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    _restaurants = await ApiService().getRestaurants();
    notifyListeners();
  }

  Future<List<FoodItem>> searchFoodItems(String query) async {
    if (query.isEmpty) return [];

    try {
      final items1 = await ApiService().getFoodItemsByRestaurant('1');
      final items2 = await ApiService().getFoodItemsByRestaurant('2');
      final items3 = await ApiService().getFoodItemsByRestaurant('3');

      final allItems = [...items1, ...items2, ...items3];

      return allItems.where((item) {
        final itemNameMatches = item.name.toLowerCase().contains(query.toLowerCase());
        final restaurant = _restaurants.firstWhere(
              (r) => r.id == item.restaurantId,
          orElse: () => Restaurant(
            id: '',
            name: '',
            image: 'assets/images/placeholder.png',
            rating: 0,
            deliveryTime: '',
            deliveryFee: 0,
            minOrder: 0,
            tags: [],
            discount: 0,
          ),
        );
        final restaurantNameMatches = restaurant.name.toLowerCase().contains(query.toLowerCase());

        return itemNameMatches || restaurantNameMatches;
      }).toList();
    } catch (e) {
      debugPrint('Error searching food items: $e');
      return [];
    }
  }
}