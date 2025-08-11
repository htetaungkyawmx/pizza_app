import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final List<Map<String, String>> orders = const [
    {'id': '1001', 'status': 'Pending'},
    {'id': '1002', 'status': 'Cooking'},
    {'id': '1003', 'status': 'On My Way'},
    {'id': '1004', 'status': 'Delivered'},
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Cooking':
        return Colors.blue;
      case 'On My Way':
        return Colors.deepPurple;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Cooking':
        return Icons.restaurant;
      case 'On My Way':
        return Icons.delivery_dining;
      case 'Delivered':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final status = order['status']!;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              leading: Icon(_statusIcon(status), color: _statusColor(status), size: 36),
              title: Text('Order ${order['id']}', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(status, style: TextStyle(color: _statusColor(status), fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Show order details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped Order #${order['id']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
