import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';
import '../models/food_item.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-endpoint.com';

  Future<List<Restaurant>> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Restaurant(
        id: '1',
        name: 'Margherita',
        description: 'Best pizza in town',
        image: 'assets/images/1.png',
        rating: 4.5,
        deliveryTime: '20-30 min',
        deliveryFee: 2.99,
        minOrder: 10.0,
        tags: ['Pizza', 'Italian', 'Pasta'],
      ),
      Restaurant(
        id: '2',
        name: 'Burger King',
        description: 'Home of the Whopper',
        image: 'assets/images/2.png',
        rating: 4.2,
        deliveryTime: '15-25 min',
        deliveryFee: 1.99,
        minOrder: 5.0,
        tags: ['Burger', 'Fast Food'],
      ),
    ];
  }

  Future<List<FoodItem>> getFoodItemsByRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      if (restaurantId == '1')
        FoodItem(
          id: '1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce and mozzarella',
          price: 8.99,
          image: 'assets/food/1.png',
          type: FoodType.pizza,
          restaurantId: '1',
          sizes: ['Small', 'Medium', 'Large'],
          addons: ['Extra Cheese', 'Mushrooms', 'Pepperoni'],
          isVeg: true,
          discount: 0.1,
        ),
      if (restaurantId == '2')
        FoodItem(
          id: '2',
          name: 'Whopper Burger',
          description: 'Classic burger with beef patty',
          price: 5.99,
          image: 'assets/food/2.png',
          type: FoodType.burger,
          restaurantId: '2',
          sizes: ['Regular', 'Large'],
          addons: ['Cheese', 'Bacon'],
          isVeg: false,
        ),
    ];
  }

  Future<List<FoodItem>> getFoodItemsByCategory(String category) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      FoodItem(
        id: '1',
        name: 'Margherita Pizza',
        description: 'Classic pizza with tomato sauce and mozzarella',
        price: 8.99,
        image: 'assets/food/1.png',
        type: FoodType.pizza,
        restaurantId: '1',
        sizes: ['Small', 'Medium', 'Large'],
        addons: ['Extra Cheese', 'Mushrooms', 'Pepperoni'],
        isVeg: true,
        discount: 0.1,
      ),
    ].where((item) => item.type.toString().split('.').last == category).toList();
  }

  Future<bool> placeOrder(Map<String, dynamic> orderData) async {
    await Future.delayed(const Duration(seconds: 1));
    return true; // Simulate successful order placement
  }
}