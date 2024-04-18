import 'package:flutter/material.dart';


class BodyPartsScreen extends StatelessWidget {
  final List<BodyPartItem> bodyParts = [
    BodyPartItem(imagePath: 'assets/head.png', name: 'Head'),
    BodyPartItem(imagePath: 'assets/eyes.png', name: 'Eyes'),
    BodyPartItem(imagePath: 'assets/ears.png', name: 'Ears'),
    BodyPartItem(imagePath: 'assets/nose.png', name: 'Nose'),
    BodyPartItem(imagePath: 'assets/mouth.png', name: 'Mouth'),
    BodyPartItem(imagePath: 'assets/arms.png', name: 'Arms'),
    BodyPartItem(imagePath: 'assets/hands.png', name: 'Hands'),
    BodyPartItem(imagePath: 'assets/legs.png', name: 'Legs'),
    BodyPartItem(imagePath: 'assets/feet.png', name: 'Feet'),
    // Add more body parts as needed
  ];

   BodyPartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Parts for Kids'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: bodyParts.length,
        itemBuilder: (context, index) {
          return _buildBodyPartCard(context, bodyParts[index]);
        },
      ),
    );
  }

  Widget _buildBodyPartCard(BuildContext context, BodyPartItem bodyPart) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(bodyPart.imagePath, height: 150, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              bodyPart.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class BodyPartItem {
  final String imagePath;
  final String name;

  BodyPartItem({
    required this.imagePath,
    required this.name,
  });
}
