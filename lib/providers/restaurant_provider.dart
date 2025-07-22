import 'package:flutter/foundation.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  final List<Restaurant> _restaurants = [
    Restaurant(
      id: '1',
      name: 'Pizza Palace',
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

  final List<FoodItem> _foodItems = [
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
      discount: 0.1, // 10% off
    ),
    FoodItem(
      id: '2',
      name: 'Pepperoni Pizza',
      description: 'Classic pizza with pepperoni',
      price: 9.99,
      image: 'assets/food/2.png',
      type: FoodType.pizza,
      restaurantId: '1',
      sizes: ['Small', 'Medium', 'Large'],
      addons: ['Extra Cheese', 'Mushrooms'],
      isVeg: false,
    ),
    FoodItem(
      id: '3',
      name: 'Whopper',
      description: 'Our signature burger',
      price: 5.99,
      image: 'assets/food/3.png',
      type: FoodType.burger,
      restaurantId: '2',
      addons: ['Cheese', 'Bacon'],
      isVeg: false,
    ),
    FoodItem(
      id: '4',
      name: 'Veggie Delight Pizza',
      description: 'Loaded with fresh veggies and cheese',
      price: 10.49,
      image: 'assets/food/4.png',
      type: FoodType.pizza,
      restaurantId: '1',
      sizes: ['Small', 'Medium', 'Large'],
      addons: ['Extra Cheese', 'Olives', 'Onions'],
      isVeg: true,
    ),
    FoodItem(
      id: '5',
      name: 'Chicken Zinger Burger',
      description: 'Crispy fried chicken in a bun',
      price: 6.49,
      image: 'assets/food/5.png',
      type: FoodType.burger,
      restaurantId: '2',
      addons: ['Spicy Sauce', 'Cheese'],
      isVeg: false,
    ),
  ];

  List<Restaurant> get restaurants => [..._restaurants];

  List<FoodItem> getFoodItemsByRestaurant(String restaurantId) {
    return _foodItems.where((item) => item.restaurantId == restaurantId).toList();
  }

  List<FoodItem> getFoodItemsByCategory(FoodType category) {
    return _foodItems.where((item) => item.type == category).toList();
  }

  List<FoodItem> searchFoodItems(String query) {
    return _foodItems.where((item) =>
    item.name.toLowerCase().contains(query.toLowerCase()) ||
        item.description.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
