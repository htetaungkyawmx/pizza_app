import 'package:flutter/material.dart';
import '../models/pizza.dart';
import '../widgets/pizza_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Pizza> pizzas = [
    Pizza(
      id: '1',
      name: 'Margherita',
      description: 'Classic delight with 100% real mozzarella cheese.',
      price: 6.0,
      image: 'assets/images/1.png',
    ),
    Pizza(
      id: '2',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/2.png',
    ),
    Pizza(
      id: '3',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/3.png',
    ),
    Pizza(
      id: '4',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/4.png',
    ),
    Pizza(
      id: '5',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/5.png',
    ),
    Pizza(
      id: '6',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/6.png',
    ),
    Pizza(
      id: '7',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/7.png',
    ),
    Pizza(
      id: '8',
      name: 'Pepperoni',
      description: 'Pepperoni and cheese – a timeless combo.',
      price: 8.5,
      image: 'assets/images/8.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Menu'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          return PizzaCard(pizza: pizzas[index]);
        },
      ),
    );
  }
}
