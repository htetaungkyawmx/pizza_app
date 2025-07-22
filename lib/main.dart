import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/restaurant_provider.dart';
import 'providers/user_provider.dart';

import 'screens/main_wrapper.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(PizzaApp());
}

class PizzaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Pizza App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
          ),
        ),
        home: MainWrapper(),
        routes: {
          '/home': (ctx) => HomeScreen(),
          '/profile': (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}
