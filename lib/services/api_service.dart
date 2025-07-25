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
        name: 'Mala Xiang Guo',
        description: 'Authentic Chinese spicy dishes',
        image: 'assets/images/mala_shan.png',
        rating: 4.5,
        deliveryTime: '20-30 min',
        deliveryFee: 2.5,
        discount: 20,
        minOrder: 10.0,
        tags: ['Mala Xiang Guo', 'Chinese'],
      ),
      Restaurant(
        id: '2',
        name: 'Biryani',
        description: 'Traditional Biryani and more',
        image: 'assets/images/dan_pauk.png',
        rating: 4.2,
        deliveryTime: '25-35 min',
        deliveryFee: 3.0,
        discount: 15,
        minOrder: 8.0,
        tags: ['Biryani', 'Burmese'],
      ),
      Restaurant(
        id: '3',
        name: 'Cool Drinks',
        description: 'Refreshing cold beverages',
        image: 'assets/images/cold_drinks.png',
        rating: 4.8,
        deliveryTime: '15-20 min',
        deliveryFee: 1.5,
        discount: 10,
        minOrder: 5.0,
        tags: ['Cold Drinks'],
      ),
      Restaurant(
        id: '4',
        name: 'Dessert Cake',
        description: 'A mouth-watering snack to satisfy your hunger',
        image: 'assets/images/sweet_treats.png',
        rating: 5.0,
        deliveryTime: '30-55 min',
        deliveryFee: 2.5,
        discount: 10,
        minOrder: 5.0,
        tags: ['Dessert Cake'],
      ),
      Restaurant(
        id: '5',
        name: 'Fried Chicken',
        description: 'Golden-brown and crunchy with a rich, savory taste.',
        image: 'assets/images/fried_chicken.png',
        rating: 4.0,
        deliveryTime: '20-45 min',
        deliveryFee: 2.5,
        discount: 10,
        minOrder: 5.0,
        tags: ['Fried Chicken'],
      ),
      Restaurant(
        id: '6',
        name: 'Fried Potato',
        description: 'Creamy, buttery mashed potatoes served smooth and warm. Comfort in every bite!',
        image: 'assets/images/fried_potato.png',
        rating: 5.0,
        deliveryTime: '30-55 min',
        deliveryFee: 2.5,
        discount: 10,
        minOrder: 5.0,
        tags: ['Fried Potato'],
      ),
    ];
  }

  Future<List<FoodItem>> getFoodItemsByRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      if (restaurantId == '1')
        FoodItem(
          id: '1',
          name: 'Mala Xiang Guo',
          description: 'Spicy Chinese beef noodles',
          price: 8.99,
          image: 'assets/images/mala_beef2.png',
          type: FoodType.mala_shan,
          restaurantId: '1',
          sizes: ['Regular', 'Large', 'Small'],
          addons: ['Extra Spice', 'Mushrooms', 'Extra Noodles'],
          isVeg: false,
          discount: 0,
        ),
      FoodItem(
        id: '6',
        name: 'Mala Spicy Beef Bowl',
        description: 'Tender slices of beef stir-fried with fresh vegetables and tossed in a bold, numbing Sichuan pepper sauce a fiery favorite for spice lovers!',
        price: 9.0,
        image: 'assets/images/mala_beef3.png',
        type: FoodType.mala_shan,
        restaurantId: '1',
        sizes: ['Regular', 'Large', 'Small'],
        addons: ['Beef', 'Extra Spicy'],
        isVeg: false,
        discount: 0,
      ),
      FoodItem(
        id: '7',
        name: 'Mala Seafood Mix',
        description: 'A sizzling mix of prawns, squid, and fish cake infused with tongue-tingling mala spices and wok-fried to perfection.',
        price: 10.0,
        image: 'assets/images/mala_beef4.png',
        type: FoodType.mala_shan,
        restaurantId: '1',
        sizes: ['Regular', 'Large', 'Small'],
        addons: ['Boiled Mala', 'Extra Seafood'],
        isVeg: false,
        discount: 0,
      ),

      if (restaurantId == '2')
        FoodItem(
          id: '2',
          name: 'Biryani Curry',
          description: 'Traditional Burmese curry',
          price: 7.50,
          image: 'assets/images/dan_pauk_curry.png',
          type: FoodType.dan_pauk,
          restaurantId: '2',
          sizes: ['Regular', 'Large', 'Small'],
          addons: ['Chicken', 'Beef'],
          isVeg: false,
          discount: 0,
        ),
      FoodItem(
        id: '8',
        name: 'Beef Biryani',
        description: ' Flavorful chunks of beef simmered with spiced rice, caramelized onions, and fresh coriander rich, hearty, and satisfying.',
        price: 8.50,
        image: 'assets/images/dan_pauk2.png',
        type: FoodType.dan_pauk,
        restaurantId: '2',
        sizes: ['Regular', 'Large', 'Small'],
        addons: ['Boiled Egg', 'Extra Beef'],
        isVeg: false,
        discount: 0,
      ),
      FoodItem(
        id: '9',
        name: 'Egg Biryani',
        description: 'Spicy biryani rice served with boiled eggs and infused with a delicate blend of Indian spices for a light yet flavorful experience.',
        price: 8.50,
        image: 'assets/images/dan_pauk3.png',
        type: FoodType.dan_pauk,
        restaurantId: '2',
        sizes: ['Regular', 'Large', 'Small'],
        addons: ['Boiled Egg', 'Extra Biryani'],
        isVeg: false,
        discount: 0,
      ),

      if (restaurantId == '3')
        FoodItem(
          id: '3',
          name: 'Summer Drink',
          description: 'Refreshing cold drink',
          price: 3.99,
          image: 'assets/images/summer_drink.png',
          type: FoodType.cold_drinks,
          restaurantId: '3',
          sizes: ['Regular', 'Large', 'Small'],
          addons: ['Extra Ice'],
          isVeg: true,
          discount: 0,
        ),
      FoodItem(
        id: '10',
        name: 'Berry Chill',
        description: 'A sweet mix of chilled berries and soda, perfect for quenching your thirst on a sunny day.',
        price: 8.50,
        image: 'assets/images/berry_drink.png',
        type: FoodType.cold_drinks,
        restaurantId: '3',
        sizes: ['Regular', 'Large', 'Small'],
        addons: ['Extra Mint', 'Less Sugar'],
        isVeg: false,
        discount: 0,
      ),
      FoodItem(
        id: '11',
        name: 'Summer Splash Drink',
        description: 'A cool and refreshing summer drink infused with citrus, mint, and just the right touch of sweetness perfect for beating the heat!',
        price: 8.50,
        image: 'assets/images/gradeful_drink.png',
        type: FoodType.cold_drinks,
        restaurantId: '3',
        sizes: ['Regular', 'Large'],
        addons: ['Extra Mint', 'Less Sugar'],
        isVeg: false,
        discount: 0,
      ),

      if (restaurantId == '5')
        FoodItem(
          id: '4',
          name: 'Crispy Fried Chicken',
          description: 'Golden-brown and crunchy with a rich, savory taste.',
          price: 6.99,
          image: 'assets/images/fried_chicken2.png',
          type: FoodType.fried_chicken,
          restaurantId: '5',
          sizes: ['Regular', 'Large', 'Spicy'],
          addons: ['Extra Sauce', 'Coleslaw'],
          isVeg: false,
          discount: 0,
        ),
      FoodItem(
        id: '12',
        name: 'Classic Crispy Chicken',
        description: 'A timeless favorite crunchy golden crust with tender chicken inside, seasoned to perfection for a mouthwatering bite.',
        price: 8.50,
        image: 'assets/images/krc.png',
        type: FoodType.fried_chicken,
        restaurantId: '5',
        sizes: ['Regular', 'Large', 'Spicy'],
        addons: ['Extra Sauce', 'Coleslaw'],
        isVeg: false,
        discount: 0,
      ),
      FoodItem(
        id: '13',
        name: 'Garlic Crispy Chicken',
        description: 'Crispy fried chicken infused with savory garlic flavor bold, crunchy, and unforgettable.',
        price: 8.50,
        image: 'assets/images/krc2.png',
        type: FoodType.fried_chicken,
        restaurantId: '5',
        sizes: ['Regular', 'Large', 'Spicy'],
        addons: ['Extra Sauce', 'Coleslaw'],
        isVeg: false,
        discount: 0,
      ),

      if (restaurantId == '6')
        FoodItem(
          id: '5',
          name: 'Buttery Mashed Potato',
          description: 'Creamy, buttery mashed potatoes served smooth and warm.',
          price: 4.50,
          image: 'assets/images/fried_potato.png',
          type: FoodType.fried_potato,
          restaurantId: '6',
          sizes: ['Small', 'Regular', 'Large'],
          addons: ['Cheese', 'Gravy'],
          isVeg: false,
          discount: 0,
        ),
      FoodItem(
        id: '14',
        name: ' Classic Butter Mash',
        description: ' Soft, fluffy potatoes whipped with real butter and a touch of seasoning — simple, rich, and satisfying.',
        price: 8.50,
        image: 'assets/images/kp.png',
        type: FoodType.fried_potato,
        restaurantId: '6',
        sizes: ['Small', 'Regular', 'Large'],
        addons: ['Cheese', 'Gravy'],
        isVeg: false,
        discount: 0,
      ),
      FoodItem(
        id: '15',
        name: 'Cheesy Mashed Potato',
        description: 'Creamy mashed potatoes blended with cheddar cheese and butter for a warm, melty delight.',
        price: 8.50,
        image: 'assets/images/kp2.png',
        type: FoodType.fried_potato,
        restaurantId: '6',
        sizes: ['Small', 'Regular', 'Large'],
        addons: ['Cheese', 'Gravy'],
        isVeg: false,
        discount: 0,
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