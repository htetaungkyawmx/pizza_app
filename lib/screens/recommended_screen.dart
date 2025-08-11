import 'package:flutter/material.dart';
import '../widgets/food_card.dart';

class RecommendedScreen extends StatelessWidget {
  final String categoryName;
  final List<Map<String, dynamic>> recommendedFoods;

  const RecommendedScreen({
    super.key,
    required this.categoryName,
    required this.recommendedFoods,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$categoryName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: recommendedFoods.length,
          itemBuilder: (context, index) {
            final food = recommendedFoods[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: FoodCard(
                name: food['name'] as String,
                price: food['price'] as double,
                image: food['image'] as String,
                isPopular: false,
                onTap: () {
                  // Optional: add navigation to food detail screen here
                },
                fallbackImage: 'assets/images/placeholder.png',
              ),
            );
          },
        ),
      ),
    );
  }
}
