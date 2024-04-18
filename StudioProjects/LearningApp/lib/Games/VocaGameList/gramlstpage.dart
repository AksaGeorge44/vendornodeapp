import 'package:flutter/material.dart';

import '../Vocabulary/noungame.dart';
import '../Vocabulary/phraselear.dart';
import '../Vocabulary/tenseler.dart';
import '../Vocabulary/verblearng.dart';

class GrammarGameListPage extends StatelessWidget {
  const GrammarGameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary Games'),
      ),
      body: ListView(
        children: [
          _buildGameCard(context, 'Vocabulary Game 1', NounLearningScreen()),
          _buildGameCard(context, 'Vocabulary Game 2', VerbLearningScreen()),
          _buildGameCard(context, 'Vocabulary Game 2', PhraseLearningScreen()),
          _buildGameCard(context, 'Vocabulary Game 2', TenseLearningScreen()),
          // ListTile(
          //   title: Text("game 2"),
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CategorySelectionPage()));
          //   },)
          // Add more vocabulary games as needed
        ],
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
