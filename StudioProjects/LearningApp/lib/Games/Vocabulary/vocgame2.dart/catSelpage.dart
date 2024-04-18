import 'package:flutter/material.dart';

import 'catpage.dart';
import 'dataSource.dart';

class CategorySelectionPage extends StatelessWidget {
  final VocabularyDataSource dataSource = VocabularyDataSource();

  final List<String> categories = ['Animals', 'Fruits', 'Home', 'Clothes', 'Food', 'Job', 'Body', 'Nature', 'Subjects', 'School'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView.builder(
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
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryPage(category),
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
