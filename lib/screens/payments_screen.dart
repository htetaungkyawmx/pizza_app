import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String? _selectedPayment;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  final List<String> paymentMethods = [
    'Visa Card',
    'Debit Card',
    'Cash on Delivery',
  ];

  bool get _requiresCardDetails =>
      _selectedPayment == 'Visa Card' || _selectedPayment == 'Debit Card';

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
      return;
    }

    if (_requiresCardDetails) {
      if (!_formKey.currentState!.validate()) return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _requiresCardDetails
              ? 'Payment method: $_selectedPayment\nCard Number: ${_cardNumberController.text}\nCard Holder: ${_cardHolderController.text}'
              : 'Payment method: $_selectedPayment',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...paymentMethods.map((method) {
              final isSelected = method == _selectedPayment;
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 3,
                child: RadioListTile<String>(
                  title: Text(method, style: const TextStyle(fontWeight: FontWeight.bold)),
                  value: method,
                  groupValue: _selectedPayment,
                  onChanged: (val) {
                    setState(() {
                      _selectedPayment = val;
                    });
                  },
                  secondary: Icon(
                    method == 'Cash on Delivery' ? Icons.money : Icons.credit_card,
                    color: isSelected ? Colors.deepOrange : Colors.grey,
                  ),
                ),
              );
            }).toList(),

            if (_requiresCardDetails)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Card number is required';
                        } else if (value.trim().length < 12) {
                          return 'Enter a valid card number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _cardHolderController,
                      decoration: const InputDecoration(
                        labelText: 'Card Holder Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Card holder name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Confirm Payment Method',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
