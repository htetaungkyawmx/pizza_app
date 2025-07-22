import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/search_bar.dart';
import '../screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurants = _selectedCategory == null
        ? restaurantProvider.restaurants
        : restaurantProvider.restaurants
        .where((restaurant) => restaurant.tags.contains(_selectedCategory))
        .toList();
    final categories = [
      Category(id: '1', name: 'Pizza', icon: Icons.local_pizza),
      Category(id: '2', name: 'Burger', icon: Icons.fastfood),
      Category(id: '3', name: 'Snack', icon: Icons.fastfood),
      Category(id: '4', name: 'Drink', icon: Icons.local_drink),
      Category(id: '5', name: 'Dessert', icon: Icons.cake),
    ];
    final promotions = [
      {'text': 'Get 20% off your first order!', 'color': Colors.red[100]},
      {'text': 'Free delivery on orders over \$20!', 'color': Colors.orange[100]},
      {'text': 'Buy 1 Get 1 Free on Pizzas!', 'color': Colors.green[100]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('PizzaApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Promotions carousel
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: promotions.length,
                itemBuilder: (ctx, index) => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: promotions[index]['color'] as Color?,
                  ),
                  child: Center(
                    child: Text(
                      promotions[index]['text'] as String,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (ctx, index) => CategoryCard(
                  category: categories[index],
                  isSelected: _selectedCategory == categories[index].name,
                  onTap: () {
                    setState(() {
                      _selectedCategory = _selectedCategory == categories[index].name
                          ? null
                          : categories[index].name;
                    });
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Restaurants',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (ctx, index) => RestaurantCard(restaurant: restaurants[index]),
            ),
          ],
        ),
      ),
    );
  }
}