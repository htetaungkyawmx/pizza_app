import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/food_item.dart';
import '../screens/food_detail_screen.dart';
import '../models/restaurant.dart';
import '../widgets/food_card.dart';
import '../widgets/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodItem> _searchResults = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);
    setState(() {
      _searchResults = restaurantProvider.searchFoodItems(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurants = restaurantProvider.restaurants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for restaurants or food',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (ctx, index) => RestaurantCard(restaurant: restaurants[index]),
            )
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (ctx, index) {
                final foodItem = _searchResults[index];
                final restaurant = restaurants.firstWhere(
                      (r) => r.id == foodItem.restaurantId,
                  orElse: () => Restaurant(
                    id: '',
                    name: 'Unknown',
                    image: '',
                    rating: 0,
                    deliveryTime: '',
                    deliveryFee: 0,
                    minOrder: 0,
                    tags: [],
                  ),
                );
                return FoodCard(
                  name: foodItem.name,
                  price: foodItem.discountedPrice,
                  image: foodItem.image,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FoodDetailScreen(
                          foodItem: foodItem,
                          restaurant: restaurant,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}