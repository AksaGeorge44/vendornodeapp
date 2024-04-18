import 'package:flutter/material.dart';
import 'package:learningapp/Games/FlashCard/flashcard.dart';
import 'package:learningapp/Games/ListeningGame/listComp.dart';
import 'package:learningapp/Games/PictQuiz/PicQuiz.dart';
import 'package:learningapp/Games/SentConst/levelSel.dart';
import 'package:learningapp/Games/Speak/Guess&Speak.dart';
import 'package:learningapp/Games/Vocabulary/noungame.dart';
import 'package:learningapp/Games/alphabetboardGame.dart';
import 'package:learningapp/Games/game1.dart';
import 'package:learningapp/Games/guessinggame1.dart';
import 'package:learningapp/Games/rhyminggame.dart';
import 'package:learningapp/Games/Finditem.dart';
import 'package:learningapp/Games/fillgame.dart';
import 'package:learningapp/Games/levelSelection.dart';
import 'package:learningapp/Games/matchname.dart';
import 'package:learningapp/Games/scrammble1.dart';
import 'package:learningapp/Games/wordup.dart';
import 'package:learningapp/levelSel2.dart';
import 'package:learningapp/levelsel.dart';
import '../CrossWord/croosword.dart';
import '../Opposite/oppositeGame.dart';
import '../Scramble.dart';
import '../Synonym/synonym.dart';
import '../storypage.dart';

class VocabularyGameListPage extends StatelessWidget {
  const VocabularyGameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildGameCard(context, 'Scramble', const ScramblePage()),
            _buildGameCard(context, 'PerfectTensegame',  LevelSelection1()),
            _buildGameCard(context, 'SentenceTyping',  LevelSelectionScreen()),
           // _buildGameCard(context, 'Fillgame', const Fill1()),
            _buildGameCard(context, 'Synony Finder',SynonymGame()),
            _buildGameCard(context, 'Guess and Speak',  GuessandSpeakGame()),
            _buildGameCard(context, 'Matching Game ',  MatchingGame()),
            _buildGameCard(context, 'Match1 ',  Match1()),
            _buildGameCard(context, 'Guess Name ',  LevelSelection()),
            _buildGameCard(context, 'Fill Name ',  FillName()),
            _buildGameCard(context, 'Sentence ',  LevelFill()),
            _buildGameCard(context, 'Finditem ',  FindItemWidget()),
            _buildGameCard(context, 'Oppositematch ',  OppositeWordsGame()),
            _buildGameCard(context, 'FlashCard',  FlashcardGame()),
            _buildGameCard(context, 'Crosswordpuzzle',  CrosswordPuzzleGame()),
            _buildGameCard(context, 'ListCompGame',  ListeningComprehensionGame()),
            _buildGameCard(context, 'PicQuizGame',  PictureQuizGame()),
            _buildGameCard(context, 'NounLearning Game', NounLearningScreen()),
            _buildGameCard(context, 'StoryGame',  StoryPage()),
            _buildGameCard(context, 'AlphabetGame',WordSearchScreen()),
            _buildGameCard(context, 'RhymingGame',RhymingGamePage()),
            _buildGameCard(context, 'WordUp',WordUpHomePage()),
            _buildGameCard(context, 'Scramble1',Scramble1()),
            _buildGameCard(context, 'Guessinggame1',GuessingGame1()),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
      BuildContext context, String gameTitle, Widget gamePage) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(gameTitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => gamePage,
            ),
          );
        },
      ),
    );
  }
}
