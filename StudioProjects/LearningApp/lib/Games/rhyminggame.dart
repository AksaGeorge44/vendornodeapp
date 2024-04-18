import 'dart:math';

import 'package:flutter/material.dart';


class RhymingGamePage extends StatefulWidget {
  @override
  _RhymingGamePageState createState() => _RhymingGamePageState();
}

class _RhymingGamePageState extends State<RhymingGamePage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> rhymingWords = ['cat', 'bat', 'hat', 'mat', 'rat']; // Example rhyming words
  String? targetWord;
  List<String> guessedWords = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    startNewRound();
  }

  void startNewRound() {
    targetWord = rhymingWords.elementAt(Random().nextInt(rhymingWords.length));
    guessedWords.clear();
    score = 0;
  }

  void checkWord(String word) {
    if (word.endsWith(targetWord!)) {
      setState(() {
        guessedWords.add(word);
        score++;
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rhyming Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Find words that rhyme with: $targetWord',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter a rhyming word',
                suffixIcon: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    checkWord(_controller.text.trim().toLowerCase());
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Guessed Words:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: guessedWords.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(guessedWords[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: startNewRound,
              child: Text('Start New Round'),
            ),
          ],
        ),
      ),
    );
  }
}
