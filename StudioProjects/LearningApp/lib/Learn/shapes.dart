import 'package:flutter/material.dart';

class ShapesScreen extends StatelessWidget {
  final List<ShapeItem> shapes = [
    ShapeItem(imagePath: 'assets/images/triangle.png', name: 'Apple'),
    ShapeItem(imagePath: 'assets/images/square.png', name: 'Banana'),
    ShapeItem(imagePath: 'assets/images/circle.png', name: 'Orange'),
    ShapeItem(imagePath: 'assets/images/rectangle.png', name: 'Grape'),
  ];

  ShapesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shapes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: shapes.length,
          itemBuilder: (context, index) {
            return _buildFruitCard(context, shapes[index]);
          },
        ),
      ),
    );
  }

  Widget _buildFruitCard(BuildContext context, ShapeItem shape) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(shape.imagePath, height: 100, width: 120),
          ),           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              shape.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ShapeItem {
  final String imagePath;
  final String name;

  ShapeItem({
    required this.imagePath,
    required this.name,
  });
}
