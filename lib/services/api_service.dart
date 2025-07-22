import 'package:flutter/material.dart';
import '../models/food_type.dart';
import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../providers/restaurant_provider.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-endpoint.com';

  Future<List<Restaurant>> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Restaurant(
        id: '1',
        name: 'Mala Shan House',
        description: 'Authentic Chinese spicy dishes',
        image: 'assets/images/mala_shan.png',
        rating: 4.5,
        deliveryTime: '20-30 min',
        deliveryFee: 2.5,
        discount: 20,
        minOrder: 10.0,
        tags: ['Mala Shan', 'Chinese'],
      ),
      Restaurant(
        id: '2',
        name: 'Burmese Bistro',
        description: 'Traditional Dan Pauk and more',
        image: 'assets/images/dan_pauk.png',
        rating: 4.2,
        deliveryTime: '25-35 min',
        deliveryFee: 3.0,
        discount: 0,
        minOrder: 8.0,
        tags: ['Dan Pauk', 'Burmese'],
      ),
      Restaurant(
        id: '3',
        name: 'Cool Drinks Cafe',
        description: 'Refreshing cold beverages',
        image: 'assets/images/cold_drinks.png',
        rating: 4.8,
        deliveryTime: '15-20 min',
        deliveryFee: 1.5,
        discount: 10,
        minOrder: 5.0,
        tags: ['Cold Drinks'],
      ),
    ];
  }

  Future<List<FoodItem>> getFoodItemsByRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      if (restaurantId == '1')
        FoodItem(
          id: '1',
          name: 'Mala Beef Noodles',
          description: 'Spicy Chinese beef noodles',
          price: 8.99,
          image: 'assets/images/mala_beef.png',
          type: FoodType.mala_shan,
          restaurantId: '1',
          sizes: ['Regular', 'Large'],
          addons: ['Extra Spice', 'Mushrooms'],
          isVeg: false,
          discount: 0.2,
        ),
      if (restaurantId == '2')
        FoodItem(
          id: '2',
          name: 'Dan Pauk Curry',
          description: 'Traditional Burmese curry',
          price: 7.50,
          image: 'assets/images/dan_pauk_curry.png',
          type: FoodType.dan_pauk,
          restaurantId: '2',
          sizes: ['Regular'],
          addons: ['Chicken', 'Beef'],
          isVeg: false,
          discount: 0,
        ),
      if (restaurantId == '3')
        FoodItem(
          id: '3',
          name: 'Iced Lemon Tea',
          description: 'Refreshing cold drink',
          price: 3.99,
          image: 'assets/images/iced_tea.png',
          type: FoodType.cold_drinks,
          restaurantId: '3',
          sizes: ['Small', 'Large'],
          addons: ['Extra Ice', 'Lemon'],
          isVeg: true,
          discount: 0.1,
        ),
    ];
  }

  Future<List<FoodItem>> getFoodItemsByCategory(String category) async {
    await Future.delayed(const Duration(seconds: 1));
    return (await getFoodItemsByRestaurant('1') +
        await getFoodItemsByRestaurant('2') +
        await getFoodItemsByRestaurant('3'))
        .where((item) => item.type.toString().split('.').last == category)
        .toList();
  }

  Future<bool> placeOrder(Map<String, dynamic> orderData) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}