import 'package:flutter/material.dart';

class SynonymGame extends StatefulWidget {
  const SynonymGame({super.key});

  @override
  State<SynonymGame> createState() => _SynonymGameState();
}

class _SynonymGameState extends State<SynonymGame> {
  final List<String> synonyms = ['joyful', 'blissful', 'cheerful', 'content', 'delighted', 'ecstatic', 'elated', 'glad'];
  final List<String> nonSynonyms = ['sad', 'angry', 'upset', 'miserable'];
  final String givenWord = 'happy';
  int score = 0;
  List<String> shuffledOptions = [];

  @override
  void initState() {
    super.initState();
    _shuffleOptions();
  }

  void _shuffleOptions() {
    List<String> allOptions = List.from(synonyms)..addAll(nonSynonyms);
    allOptions.shuffle();
    setState(() {
      shuffledOptions = allOptions;
    });
  }

  void _checkAnswer(String selectedWord) {
    setState(() {
      if (synonyms.contains(selectedWord)) {
        score++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correct!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect!'),
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Synonym Finder"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Text(
            'Find synonyms of "$givenWord":',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _checkAnswer(shuffledOptions[0]),
                child: Text(shuffledOptions[0]),
              ),
              ElevatedButton(
                onPressed: () => _checkAnswer(shuffledOptions[1]),
                child: Text(shuffledOptions[1]),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _checkAnswer(shuffledOptions[2]),
                child: Text(shuffledOptions[2]),
              ),
              ElevatedButton(
                onPressed: () => _checkAnswer(shuffledOptions[3]),
                child: Text(shuffledOptions[3]),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            'Score: $score',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
