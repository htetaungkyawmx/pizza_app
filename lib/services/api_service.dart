import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/food_item.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-endpoint.com';

  Future<List<Restaurant>> getRestaurants() async {
    // In a real app, this would make an API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [];
  }

  Future<List<FoodItem>> getFoodItemsByRestaurant(String restaurantId) async {
    await Future.delayed(Duration(seconds: 1));
    return [];
  }

  Future<List<FoodItem>> getFoodItemsByCategory(String category) async {
    await Future.delayed(Duration(seconds: 1));
    return [];
  }

  Future<bool> placeOrder(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderData),
    );
    return response.statusCode == 201;
  }
}