import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final List<String> orderedItems;

  const OrderConfirmationScreen({Key? key, required this.orderedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Column(
        children: [
          const Text('Ordered Items:'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: orderedItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(orderedItems[index]),
              );
            },
          ),
          // ... other UI components ...
        ],
      ),
    );
  }
}
