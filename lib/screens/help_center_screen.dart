import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'How to place an order?',
      'answer': 'Select your favorite items and checkout easily.',
    },
    {
      'question': 'What payment methods are available?',
      'answer': 'Visa, Debit, and Cash on Delivery are supported.',
    },
    {
      'question': 'How to use vouchers?',
      'answer': 'Apply vouchers at checkout to get discounts.',
    },
    {
      'question': 'How to contact support?',
      'answer': 'Use the contact option in the app or call us.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return ExpansionTile(
            leading: const Icon(Icons.help_outline, color: Colors.deepOrange),
            title: Text(
              faq['question']!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Text(
                faq['answer']!,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          );
        },
      ),
    );
  }
}
