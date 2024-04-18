import 'package:flutter/material.dart';
import 'package:learningapp/Games/colors.dart';

import 'Guess&Speak.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List<String> categories = [
    'Animals', 'Fruits', 'Birds', 'Insects', 'Food', 'Job', 'Body Parts',
    'Nature', 'Seasons', 'School Things',
  ];

  CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            return _buildCategoryCard(context, category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    late Widget gamePage;

    // Conditionally select the appropriate game page for each category
    switch (category) {
      case 'Animals':
        gamePage = GuessandSpeakGame();
        break;
      case 'Fruits':
      // Add code for Fruits game page
        gamePage = Colours();
        break;
    // Add cases for other categories

      default:
        gamePage = Container(); // A placeholder, you can customize this based on your needs
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => gamePage,
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.category, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(
              category,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );


  }
}
