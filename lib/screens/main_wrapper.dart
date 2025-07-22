import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart' as cartProvider;
import '../providers/restaurant_provider.dart' as restProvider;
import '../providers/user_provider.dart' as userProvider;
import 'home_screen.dart';

class MainWrapper extends StatefulWidget {
  @override
  _MainWrapperState createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => cartProvider.CartProvider()),
        ChangeNotifierProvider(create: (_) => restProvider.RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => userProvider.UserProvider()),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            Center(child: Text('Search Screen')),
            Center(child: Text('Cart Screen')),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
