import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchBar({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextField(
        enabled: false, // Disable direct input, navigate to SearchScreen
        decoration: InputDecoration(
          hintText: 'Search for restaurants or food',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}