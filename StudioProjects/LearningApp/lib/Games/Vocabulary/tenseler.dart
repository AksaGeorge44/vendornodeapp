import 'package:flutter/material.dart';

class TenseLearningScreen extends StatelessWidget {
  // final FlutterTts flutterTts = FlutterTts();

  final List<TenseItem> tenses = [
    TenseItem(tense: 'Present Simple', example: 'I play tennis every day.'),
    TenseItem(tense: 'Past Simple', example: 'She visited the museum yesterday.'),
    TenseItem(tense: 'Future Simple', example: 'We will go to the park tomorrow.'),
    // Add more tenses as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Tenses'),
      ),
      body: ListView.builder(
        itemCount: tenses.length,
        itemBuilder: (context, index) {
          return _buildTenseCard(context, tenses[index]);
        },
      ),
    );
  }

  Widget _buildTenseCard(BuildContext context, TenseItem tense) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tense.tense,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            tense.example,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _speakExample(tense.example);
            },
            child: Text('Speaker'),
          ),
        ],
      ),
    );
  }

  Future<void> _speakExample(String example) async {
    // await flutterTts.setLanguage('en-US');
    // await flutterTts.speak(example);
  }
}

class TenseItem {
  final String tense;
  final String example;

  TenseItem({required this.tense, required this.example});
}
