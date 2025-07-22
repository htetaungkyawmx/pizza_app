import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/restaurant_provider.dart';
import '../models/category.dart';
import '../models/food_item.dart';
import '../widgets/category_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/food_card.dart';
import '../widgets/search_bar.dart';
import '../screens/search_screen.dart';
import '../screens/restaurant_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCategory;
  late Future<List<FoodItem>> _popularFoodsFuture;

  @override
  void initState() {
    super.initState();
    _popularFoodsFuture = _fetchPopularFoods();
  }

  Future<List<FoodItem>> _fetchPopularFoods() async {
    final apiService = ApiService();

    final items1 = await apiService.getFoodItemsByRestaurant('1');
    final items2 = await apiService.getFoodItemsByRestaurant('2');
    final items3 = await apiService.getFoodItemsByRestaurant('3');

    final allItems = [...items1, ...items2, ...items3];
    allItems.sort((a, b) => b.rating.compareTo(a.rating));
    return allItems.take(6).toList(); // Top 6 popular items
  }

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
        title: const Text('Food App'),
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
            // -------------------- Promotions --------------------
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

            // -------------------- Search Bar --------------------
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
            ),

            // -------------------- Categories --------------------
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

            // -------------------- ✅ Popular Foods --------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Popular Foods',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220,
              child: FutureBuilder<List<FoodItem>>(
                future: _popularFoodsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No popular items available'));
                  }

                  final popularFoods = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularFoods.length,
                    itemBuilder: (ctx, index) => Container(
                      width: 160,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: FoodCard(
                        name: popularFoods[index].name,
                        price: popularFoods[index].discountedPrice,
                        image: popularFoods[index].image,
                        isPopular: true,
                        onTap: () {
                          final restaurant = restaurantProvider.restaurants.firstWhere(
                                (r) => r.id == popularFoods[index].restaurantId,
                            orElse: () => Restaurant(
                              id: '',
                              name: 'Unknown',
                              image: '',
                              rating: 0,
                              deliveryTime: '',
                              deliveryFee: 0,
                              minOrder: 0,
                              tags: [],
                              discount: 0,
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RestaurantScreen(restaurant: restaurant),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // -------------------- Restaurants --------------------
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
