import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // You can use the AppProvider to get the necessary order information
    // For example:
    // AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmation"),
      ),
      body: const Center(
        child: Text("Display order confirmation details here"),
      ),
    );
  }
}
