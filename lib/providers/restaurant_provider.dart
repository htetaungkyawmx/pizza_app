import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';

class RestaurantProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Restaurant> _restaurants = [];
  List<FoodItem> _foodItems = [];

  RestaurantProvider() {
    _fetchData();
  }

  List<Restaurant> get restaurants => [..._restaurants];

  Future<void> _fetchData() async {
    _restaurants = await _apiService.getRestaurants();
    _foodItems = await _apiService.getFoodItemsByRestaurant('1'); // Fetch for default restaurant
    notifyListeners();
  }

  List<FoodItem> getFoodItemsByRestaurant(String restaurantId) {
    return _foodItems.where((item) => item.restaurantId == restaurantId).toList();
  }

  List<FoodItem> getFoodItemsByCategory(FoodType category) {
    return _foodItems.where((item) => item.type == category).toList();
  }

  List<FoodItem> searchFoodItems(String query) {
    return _foodItems.where((item) =>
    item.name.toLowerCase().contains(query.toLowerCase()) ||
        item.description.toLowerCase().contains(query.toLowerCase())).toList();
  }
}