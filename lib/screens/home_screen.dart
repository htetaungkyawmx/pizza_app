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
      Category(id: '1', name: 'Mala Shan', icon: Icons.restaurant_menu, image: 'assets/images/mala_shan.png'),
      Category(id: '2', name: 'Dan Pauk', icon: Icons.rice_bowl, image: 'assets/images/dan_pauk.png'),
      Category(id: '3', name: 'Cold Drinks', icon: Icons.local_drink, image: 'assets/images/cold_drinks.png'),
      Category(id: '4', name: 'Pizza', icon: Icons.local_pizza, image: 'assets/images/pizza.png'),
      Category(id: '5', name: 'Dessert', icon: Icons.cake, image: 'assets/images/dessert.png'),
    ];
    final promotions = [
      {'text': '30% OFF Mala Shan dishes!', 'image': 'assets/images/promo.png', 'color': Colors.red[100]},
      {'text': 'Free delivery on Burmese food!', 'image': 'assets/images/promo_burmese.png', 'color': Colors.orange[100]},
      {'text': 'Buy 1 Get 1 Cold Drinks!', 'image': 'assets/images/promo.png', 'color': Colors.blue[100]},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('음식 앱'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: promotions.length,
                itemBuilder: (ctx, index) => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(promotions[index]['image'] as String),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      promotions[index]['text'] as String,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
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