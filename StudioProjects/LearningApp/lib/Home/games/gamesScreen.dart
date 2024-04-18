import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Games'),
      ),
      body: Column(
        children: [
          _buildAgeSection(context, '2-3 years'),
          _buildAgeSection(context, '4-5 years'),
          _buildAgeSection(context, '6-10 years'),
        ],
      ),
    );
  }

  Widget _buildAgeSection(BuildContext context, String ageRange) {
    return GestureDetector(
      onTap: () {
        // Navigate to the specific game for the selected age range
        // You can replace this with your own logic
      },
      child: Card(
        child: ListTile(
          title: Text(ageRange),
          subtitle: Text('Game for $ageRange'),
        ),
      ),
    );
  }
}
