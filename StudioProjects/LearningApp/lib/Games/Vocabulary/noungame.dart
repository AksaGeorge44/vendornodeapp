import 'package:flutter/material.dart';

class NounLearningScreen extends StatelessWidget {
  // final FlutterTts flutterTts = FlutterTts();

  final List<NounItem> nouns = [
    NounItem(name: 'Dog', image: 'assets/images/dog.jpg'),
    NounItem(name: 'Cat', image: 'assets/images/cat.jpg'),
    NounItem(name: 'Tree', image: 'assets/images/tree.jpg'),
    // Add more nouns as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Nouns'),
      ),
      body: ListView.builder(
        itemCount: nouns.length,
        itemBuilder: (context, index) {
          return _buildNounCard(context, nouns[index]);
        },
      ),
    );
  }

  Widget _buildNounCard(BuildContext context, NounItem noun) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            noun.image,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            noun.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _speakWord(noun.name);
            },
            child: Text('Speaker'),
          ),
        ],
      ),
    );
  }

  Future<void> _speakWord(String word) async {
    // await flutterTts.setLanguage('en-US');
    // await flutterTts.speak(word);
  }
}

class NounItem {
  final String name;
  final String image;

  NounItem({required this.name, required this.image});
}
