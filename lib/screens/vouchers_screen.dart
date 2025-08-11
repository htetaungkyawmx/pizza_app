import 'package:flutter/material.dart';

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

  final List<Map<String, String>> previousOrders = const [
    {
      'orderId': '1001',
      'status': 'Delivered',
      'payment': 'Visa Card',
      'delivery': 'Home Delivery',
      'date': '2024-08-01',
    },
    {
      'orderId': '1002',
      'status': 'In Transit',
      'payment': 'Cash on Delivery',
      'delivery': 'Pickup',
      'date': '2024-08-05',
    },
    {
      'orderId': '1003',
      'status': 'Preparing',
      'payment': 'Debit Card',
      'delivery': 'Home Delivery',
      'date': '2024-08-10',
    },
  ];

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'in transit':
        return Colors.orange;
      case 'preparing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _paymentIcon(String payment) {
    switch (payment.toLowerCase()) {
      case 'visa card':
        return Icons.credit_card;
      case 'debit card':
        return Icons.account_balance_wallet;
      case 'cash on delivery':
        return Icons.money;
      default:
        return Icons.payment;
    }
  }

  IconData _deliveryIcon(String delivery) {
    switch (delivery.toLowerCase()) {
      case 'home delivery':
        return Icons.home;
      case 'pickup':
        return Icons.store;
      default:
        return Icons.local_shipping;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vouchers & Previous Orders')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: previousOrders.length,
        itemBuilder: (context, index) {
          final order = previousOrders[index];
          final status = order['status'] ?? '';
          final payment = order['payment'] ?? '';
          final delivery = order['delivery'] ?? '';
          final date = order['date'] ?? '';

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ${order['orderId']}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(status),
                        backgroundColor: _statusColor(status).withOpacity(0.2),
                        labelStyle: TextStyle(color: _statusColor(status), fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(date, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      Icon(_paymentIcon(payment), color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Text('Payment: $payment'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(_deliveryIcon(delivery), color: Colors.deepOrange),
                      const SizedBox(width: 8),
                      Text('Delivery: $delivery'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
