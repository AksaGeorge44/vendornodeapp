import 'package:flutter/material.dart';


class WordMatchingGame extends StatefulWidget {
  const WordMatchingGame({super.key});

  @override
  _WordMatchingGameState createState() => _WordMatchingGameState();
}

class _WordMatchingGameState extends State<WordMatchingGame> {
  List<String> words = ['Apple', 'Banana', 'Orange', 'Grapes'];
  List<String> shuffledWords = [];
  List<String> images = [
    'apple.jpg',
    'banana.jpg',
    'orange.jpg',
    'grapes.jpg',
  ];

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(words)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Matching Game'),
      ),
      body: Column(
        children: [
          _buildImagesGrid(),
          _buildWordsList(),
        ],
      ),
    );
  }

  Widget _buildImagesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImageCard(index);
      },
    );
  }

  Widget _buildImageCard(int index) {
    return Card(
      child: DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/${images[index]}',
              fit: BoxFit.cover,
            ),
          );
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          _handleWordDrop(index, data);
        },
      ),
    );
  }

  Widget _buildWordsList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (String word in shuffledWords) _buildDraggableWord(word),
      ],
    );
  }

  Widget _buildDraggableWord(String word) {
    return Draggable<String>(
      data: word,
      feedback: _buildDraggableFeedback(word),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          word,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      childWhenDragging: Container(),
    );
  }

  Widget _buildDraggableFeedback(String word) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        word,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void _handleWordDrop(int imageIndex, String word) {
    // Check if the dropped word matches the correct word for the image
    if (word == words[imageIndex]) {
      // Provide feedback for correct match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correct Match!'),
          duration: Duration(seconds: 1),
        ),
      );

      // Remove the matched word from the list
      setState(() {
        shuffledWords.remove(word);
      });

      // You can add additional logic for when all matches are correct
    } else {
      // Provide feedback for incorrect match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect Match! Try again.'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
