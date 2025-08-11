import 'package:flutter/material.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  final List<String> addresses = const [
    '서울특별시 중구 세종대로 110',           // Seoul City Hall address
    '부산광역시 해운대구 우동 1410',        // Busan Haeundae District
    '대구광역시 중구 동성로2가 52-1',       // Daegu Jung-gu District
    '인천광역시 연수구 송도동 15-1',        // Incheon Songdo District
    '광주광역시 동구 충장로 22',             // Gwangju Downtown
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Addresses')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.location_on, color: Colors.deepOrange),
              title: Text(address, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: IconButton(
                icon: const Icon(Icons.map, color: Colors.deepOrange),
                onPressed: () {
                  // You can add map integration here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Show map for:\n$address')),
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
