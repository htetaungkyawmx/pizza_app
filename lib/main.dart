import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/restaurant_provider.dart';
import 'providers/user_provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/search_screen.dart';
import 'screens/main_wrapper.dart';

void main() {
  runApp(const PizzaApp());
}

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'FoodieApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.black87),
          ),
        ),
        home: const LoginScreen(),
        routes: {
          '/home': (ctx) => const HomeScreen(),
          '/profile': (ctx) => const ProfileScreen(),
          '/cart': (ctx) => CartScreen(),
          '/search': (ctx) => SearchScreen(),
          '/main': (ctx) => MainWrapper(),
        },
      ),
    );
  }
}
