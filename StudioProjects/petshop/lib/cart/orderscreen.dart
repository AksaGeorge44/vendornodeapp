import 'package:flutter/material.dart';

class OrderScreens extends StatelessWidget {
  final double totalprice;
  final List<CartItem> itemList;

  const OrderScreens({super.key, required this.totalprice, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (ctx, index) {
                final cartItem = itemList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      // leading: Image.asset(
                      //   cartItem.productImage, // Assuming you have an asset path for each product image
                      //   width: 60,
                      //   height: 60,
                      //   fit: BoxFit.cover,
                      // ),
                      title: Text(cartItem.productName),
                      subtitle: Text("Quantity: ${cartItem.qty}"),
                      trailing: Text("₹${cartItem.totalPrice}"),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Total Price: ₹$totalprice", style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String productName;
  final int? qty;
  final double totalPrice;
  final String productImage; // Add product image property

  CartItem({
    required this.productName,
    this.qty,
    required this.totalPrice,
    required this.productImage,
  });
}
