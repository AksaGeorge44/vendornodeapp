import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';


class FlashcardGame extends StatefulWidget {
  @override
  _FlashcardGameState createState() => _FlashcardGameState();
}

class _FlashcardGameState extends State<FlashcardGame> {
 // final FlutterTts flutterTts = FlutterTts();
  List<Flashcard> flashcards = [
    Flashcard(
      imagePath: 'assets/images/cat.png',
      word: 'Cat',
    ),
    Flashcard(
      imagePath: 'assets/images/dog.png',
      word: 'Dog',
    ),
  ];

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flashcard Game'),
      ),
      body: Swiper(
        itemCount: flashcards.length,
        itemBuilder: (BuildContext context, int index) {
          Flashcard flashcard = flashcards[index];
          return _buildFlashcard(flashcard);
        },
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }

  Widget _buildFlashcard(Flashcard flashcard) {
    TextEditingController _textEditingController = TextEditingController();

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              flashcard.imagePath,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _speakWord(flashcard.word);
              },
              child: Text('Pronounce'),
            ),
            Padding(
              padding: const EdgeInsets.all(55.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Type the word you heard',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String typedWord = _textEditingController.text.trim().toLowerCase();
                String correctWord = flashcard.word.toLowerCase();
                if (typedWord == correctWord) {
                  setState(() {
                    score++;
                  });

                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 10),
            Text('Score: $score'),
          ],
        ),
      ),
    );
  }


  Future<void> _speakWord(String word) async {
    //await flutterTts.speak(word);
  }
}

class Flashcard {
  final String imagePath;
  final String word;

  Flashcard({
    required this.imagePath,
    required this.word,
  });
}


