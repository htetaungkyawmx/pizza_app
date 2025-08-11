import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  final List<Map<String, String>> favourites = const [
    {
      'name': 'Pizza Margherita',
      'image': 'assets/images/Pizza Margherita.png',
    },
    {
      'name': 'Spaghetti Carbonara',
      'image': 'assets/images/Spaghetti Carbonara.png',
    },
    {
      'name': 'Caesar Salad',
      'image': 'assets/images/Caesar Salad.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          final fav = favourites[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  fav['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 60);
                  },
                ),
              ),
              title: Text(
                fav['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {
                  // TODO: Add/remove favourite logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${fav['name']} clicked')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
