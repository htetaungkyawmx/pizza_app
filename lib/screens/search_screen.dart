import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../screens/food_detail_screen.dart';
import '../widgets/food_card.dart';
import '../widgets/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _search(String query) {
    setState(() {
      _query = query.trim();
      _isSearching = query.isNotEmpty;
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
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: _query.isEmpty
                ? ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (ctx, index) =>
                  RestaurantCard(restaurant: restaurants[index], onTap: () {  },),
            )
                : FutureBuilder<List<FoodItem>>(
              future: restaurantProvider.searchFoodItems(_query),
              builder: (context, AsyncSnapshot<List<FoodItem>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                final searchResults = snapshot.data ?? [];

                if (searchResults.isEmpty) {
                  return const Center(
                    child: Text('No results found'),
                  );
                }

                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (ctx, index) {
                    final foodItem = searchResults[index];
                    final restaurant = restaurants.firstWhere(
                          (r) => r.id == foodItem.restaurantId,
                      orElse: () => Restaurant(
                        id: '',
                        name: 'Unknown',
                        image: 'assets/images/placeholder.png',
                        rating: 0,
                        deliveryTime: '',
                        deliveryFee: 0,
                        minOrder: 0,
                        tags: [],
                        discount: 0,
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
                      }, fallbackImage: '', isPopular: false,
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