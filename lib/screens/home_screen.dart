import 'dart:async';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/restaurant_provider.dart';
import '../screens/recommended_screen.dart';
import '../screens/restaurant_screen.dart';
import '../widgets/category_card.dart';
import '../widgets/food_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = -1;
  int _currentPromoIndex = 0;
  int _currentPopularIndex = 0;
  Timer? _promoTimer;
  Timer? _popularTimer;
  bool _isLoading = true;
  String? _errorMessage;

  final PageController _promoPageController = PageController();
  final PageController _popularPageController = PageController(viewportFraction: 1.0); // Full width

  final Map<String, List<Map<String, dynamic>>> categoryFoods = {
    'Mala Xiang Guo': [
      {'name': 'Mala Hotpot', 'price': 6.0, 'image': 'assets/images/mala.png'},
    ],
    'Biryani': [
      {'name': 'Chicken Biryani', 'price': 8.0, 'image': 'assets/images/dan_pauk.png'},
    ],
    'Drinks': [
      {'name': 'Ice Tea', 'price': 1.5, 'image': 'assets/images/iced_tea.png'},
    ],
    'Pizza': [
      {'name': 'Pepperoni Pizza', 'price': 11.0, 'image': 'assets/images/pizza.png'},
    ],
    'Dessert': [
      {'name': 'Chocolate Cake', 'price': 3.5, 'image': 'assets/images/sweet_treats.png'},
    ],
  };

  final promotions = [
    {'text': '25% Off Mala Xiang Guo!', 'image': 'assets/images/mala_shan.png', 'color': Colors.red[100]},
    {'text': 'Free delivery on Burmese food!', 'image': 'assets/images/promo_burmese.png', 'color': Colors.orange[100]},
    {'text': 'Buy 1 Get 1 Cold Drinks!', 'image': 'assets/images/summer_drink.png', 'color': Colors.blue[100]},
    {'text': '10% Off Spicy Noodles!', 'image': 'assets/images/noodles.png', 'color': Colors.deepOrangeAccent[100]},
  ];

  final popularFoods = [
    {'name': 'Burger', 'price': 3.0, 'image': 'assets/images/burger.png'},
    {'name': 'Spicy Noodles', 'price': 5.0, 'image': 'assets/images/noodles.png'},
    {'name': 'Pizza', 'price': 10.0, 'image': 'assets/images/pizza.png'},
    {'name': 'Mala Hotpot', 'price': 5.0, 'image': 'assets/images/mala.png'},
    {'name': 'Ice Cream', 'price': 2.0, 'image': 'assets/images/ice_cream.png'},
    {'name': 'Tea', 'price': 1.0, 'image': 'assets/images/tea.png'},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
    _startPromoAutoScroll();
    _startPopularAutoScroll();
  }

  @override
  void dispose() {
    _promoTimer?.cancel();
    _popularTimer?.cancel();
    _promoPageController.dispose();
    _popularPageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      await Provider.of<RestaurantProvider>(context, listen: false).fetchRestaurants();
      setState(() => _isLoading = false);
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load restaurants. Please try again.';
      });
    }
  }

  void _startPromoAutoScroll() {
    _promoTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_promoPageController.hasClients) {
        final nextPage = (_currentPromoIndex + 1) % promotions.length;
        _promoPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPromoIndex = nextPage);
      }
    });
  }

  void _startPopularAutoScroll() {
    _popularTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_popularPageController.hasClients) {
        final nextPage = (_currentPopularIndex + 1) % popularFoods.length;
        _popularPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() => _currentPopularIndex = nextPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final restaurants = restaurantProvider.restaurants;

    final categories = [
      Category(id: '1', name: 'Mala Xiang Guo', icon: Icons.restaurant_menu, image: 'assets/images/mala_shan.png'),
      Category(id: '2', name: 'Biryani', icon: Icons.rice_bowl, image: 'assets/images/dan_pauk.png'),
      Category(id: '3', name: 'Drinks', icon: Icons.local_drink, image: 'assets/images/cold_drinks.png'),
      Category(id: '4', name: 'Pizza', icon: Icons.local_pizza, image: 'assets/images/pizza.png'),
      Category(id: '5', name: 'Dessert', icon: Icons.cake, image: 'assets/images/berry_cake.png'),
    ];

    final filteredRestaurants = _selectedCategoryIndex == -1
        ? restaurants
        : restaurants.where((restaurant) {
      final selectedCategory = categories[_selectedCategoryIndex].name.toLowerCase();
      return restaurant.tags.any((tag) => tag.toLowerCase() == selectedCategory);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('음식앱'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? Center(child: Text(_errorMessage!))
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBar(
                  onTap: () => Navigator.pushNamed(context, '/search'),
                ),
              ),

              // Promotions slider
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _promoPageController,
                  itemCount: promotions.length,
                  onPageChanged: (index) => setState(() => _currentPromoIndex = index),
                  itemBuilder: (ctx, index) => Container(
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

              // Categories
              SizedBox(
                height: 105,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (ctx, index) => CategoryCard(
                    category: categories[index],
                    isSelected: _selectedCategoryIndex == index,
                    onTap: () {
                      setState(() => _selectedCategoryIndex = index);
                      final selectedCategory = categories[index];
                      final selectedFoods = categoryFoods[selectedCategory.name] ?? [];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecommendedScreen(
                            categoryName: selectedCategory.name,
                            recommendedFoods: selectedFoods,
                          ),
                        ),
                      ).then((_) {
                        setState(() => _selectedCategoryIndex = -1);
                      });
                    },
                  ),
                ),
              ),

              // Popular Foods slider
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 230,
                child: PageView.builder(
                  controller: _popularPageController,
                  itemCount: popularFoods.length,
                  onPageChanged: (index) => setState(() => _currentPopularIndex = index),
                  itemBuilder: (ctx, index) => FoodCard(
                    name: popularFoods[index]['name'] as String,
                    price: popularFoods[index]['price'] as double,
                    image: popularFoods[index]['image'] as String,
                    isPopular: true,
                    onTap: () {},
                    fallbackImage: 'assets/images/placeholder.png',
                  ),
                ),
              ),

              // Delicious foods
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Delicious foods',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRestaurants.length,
                itemBuilder: (ctx, index) => RestaurantCard(
                  restaurant: filteredRestaurants[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantScreen(restaurant: filteredRestaurants[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
