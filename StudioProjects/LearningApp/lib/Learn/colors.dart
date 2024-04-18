import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  final List<Item> items = [
    Item(name: 'Red', type: ItemType.Color, color: Colors.red),
    Item(name: 'Blue', type: ItemType.Color, color: Colors.blue),
    Item(name: 'Yellow', type: ItemType.Color, color: Colors.yellow),
    Item(name: 'Black', type: ItemType.Color, color: Colors.black),
    Item(name: 'Teal', type: ItemType.Color, color: Colors.teal),
    Item(name: 'White', type: ItemType.Color, color: Colors.white),
    Item(name: 'Orange', type: ItemType.Color, color: Colors.orange),
    Item(name: 'Brown', type: ItemType.Color, color: Colors.brown),
    Item(name: 'Green', type: ItemType.Color, color: Colors.green),
    Item(name: 'Grey', type: ItemType.Color, color: Colors.grey),
    Item(name: 'Lime', type: ItemType.Color, color: Colors.lime),
    Item(name: 'Pink', type: ItemType.Color, color: Colors.pink),
    Item(name: 'Purple', type: ItemType.Color, color: Colors.purple),

  ];

   LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colours"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildItemCard(context, items[index]);
          },
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Item item) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150, // Adjust the height as needed
            color: item.type == ItemType.Color ? item.color : Colors.transparent,
            child: Center(
              child: item.type == ItemType.Shape
                  ? _buildShapeWidget(item)
                  : Text(
                item.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildShapeWidget(Item item) {
    if (item.shape == BoxShape.rectangle) {
      return Container(
        width: 100,
        height: 100,
        color: item.color,
      );
    } else if (item.shape == BoxShape.circle) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item.color,
        ),
      );
    } else {
      return Container(); // Placeholder, you can add more shapes as needed
    }
  }
}

enum ItemType { Color, Shape, Number }

class Item {
  final String name;
  final ItemType type;
  final Color? color;
  final BoxShape? shape;

  Item({
    required this.name,
    required this.type,
    this.color,
    this.shape,
  });
}
