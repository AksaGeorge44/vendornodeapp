import 'package:flutter/material.dart';

class PhraseLearningScreen extends StatelessWidget {
  // final FlutterTts flutterTts = FlutterTts();

  final List<PhraseItem> phrases = [
    PhraseItem(phrase: 'Hello, how are you?', image: 'assets/images/hello.jpg'),
    PhraseItem(phrase: 'Good morning!', image: 'assets/images/good_morning.jpg'),
    PhraseItem(phrase: 'Thank you!', image: 'assets/images/thank_you.jpg'),
    // Add more phrases as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Phrases'),
      ),
      body: ListView.builder(
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          return _buildPhraseCard(context, phrases[index]);
        },
      ),
    );
  }

  Widget _buildPhraseCard(BuildContext context, PhraseItem phrase) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            phrase.image,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            phrase.phrase,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _speakPhrase(phrase.phrase);
            },
            child: Text('Speaker'),
          ),
        ],
      ),
    );
  }

  Future<void> _speakPhrase(String phrase) async {
    // await flutterTts.setLanguage('en-US');
    // await flutterTts.speak(phrase);
  }
}

class PhraseItem {
  final String phrase;
  final String image;

  PhraseItem({required this.phrase, required this.image});
}
