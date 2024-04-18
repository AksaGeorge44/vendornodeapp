import 'package:flutter/material.dart';

class VerbLearningScreen extends StatelessWidget {
  // final FlutterTts flutterTts = FlutterTts();

  final List<VerbItem> verbs = [
    VerbItem(name: 'Run', image: 'assets/images/run.jpg'),
    VerbItem(name: 'Jump', image: 'assets/images/jump.jpg'),
    VerbItem(name: 'Read', image: 'assets/images/read.jpg'),
    // Add more verbs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Verbs'),
      ),
      body: ListView.builder(
        itemCount: verbs.length,
        itemBuilder: (context, index) {
          return _buildVerbCard(context, verbs[index]);
        },
      ),
    );
  }

  Widget _buildVerbCard(BuildContext context, VerbItem verb) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            verb.image,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            verb.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _speakWord(verb.name);
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

class VerbItem {
  final String name;
  final String image;

  VerbItem({required this.name, required this.image});
}
