import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NaraonRewardsScreen extends StatelessWidget {
  const NaraonRewardsScreen({super.key});

  final List<Map<String, String>> rewards = const [
    {'title': 'Free Pizza', 'description': 'Redeem with 100 points'},
    {'title': '10% Discount', 'description': 'Redeem with 50 points'},
    {'title': 'Free Drink', 'description': 'Redeem with 30 points'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Naraon Rewards')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Your Rewards',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events, color: Colors.amber),
                      title: Text(reward['title']!),
                      subtitle: Text(reward['description']!),
                      trailing: ElevatedButton(
                        child: const Text('Redeem'),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Redeemed ${reward['title']}!')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
