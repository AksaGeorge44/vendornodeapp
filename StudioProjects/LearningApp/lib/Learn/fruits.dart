import 'package:flutter/material.dart';

class FruitsScreen extends StatelessWidget {
  final List<FruitItem> fruits = [
    FruitItem(imagePath: 'assets/images/apple.png', name: 'Apple'),
    FruitItem(imagePath: 'assets/images/banana.png', name: 'Banana'),
    FruitItem(imagePath: 'assets/images/orange.png', name: 'Orange'),
    FruitItem(imagePath: 'assets/images/grape.png', name: 'Grape'),
  ];

   FruitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            return _buildFruitCard(context, fruits[index]);
          },
        ),
      ),
    );
  }

  Widget _buildFruitCard(BuildContext context, FruitItem fruit) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(fruit.imagePath, height: 100, width: 120),
          ),           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              fruit.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class FruitItem {
  final String imagePath;
  final String name;

  FruitItem({
    required this.imagePath,
    required this.name,
  });
}
