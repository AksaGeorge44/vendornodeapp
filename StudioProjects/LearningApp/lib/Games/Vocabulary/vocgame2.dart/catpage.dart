import 'package:flutter/material.dart';

import 'dataSource.dart';
import 'model.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage(this.category, {super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final VocabularyDataSource dataSource = VocabularyDataSource();

  // final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _speakWord("Lion");
    });
  }

  @override
  Widget build(BuildContext context) {

    List<VocabularyItem> items = _getItemsForCategory();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          VocabularyItem item = items[index];
          return _buildItemCard(context, item);
        },
      ),
    );
  }

  List<VocabularyItem> _getItemsForCategory() {
    switch (widget.category) {
      case 'Animals':
        return dataSource.getAnimals();
    // Add cases for other categories
      default:
        return [];
    }
  }

  Widget _buildItemCard(BuildContext context, VocabularyItem item) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(item.imagePath, height: 80, width: 80),
          SizedBox(height: 10),
          Text(
            item.name,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _speakWord(item.name);
            },
            child: Text('Speaker'),
          ),
        ],
      ),
    );
  }

  Future<void> _speakWord(String word) async {
    // await flutterTts.setLanguage("en-US");
    // await flutterTts.setPitch(1.0);
    // await flutterTts.setSpeechRate(0.5);
    // await flutterTts.speak(word);
  }
}
