import 'package:flutter/material.dart';
import 'package:learningapp/senttypegame.dart';

class LevelSelectionScreen extends StatefulWidget {
  @override
  _LevelSelectionScreenState createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  List<bool> completedLevels = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            bool isUnlocked = index == 0 || completedLevels[index - 1];
            return GestureDetector(
              onTap: isUnlocked ? () => _navigateToGameScreen(context, index + 1) : null,
              child: Card(
                color: isUnlocked ? Colors.blueAccent : Colors.grey.withOpacity(0.5),
                child: ListTile(
                  leading: Icon(isUnlocked ? Icons.lock_open : Icons.lock),
                  title: Text('Level ${index + 1}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateToGameScreen(BuildContext context, int level) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SentenceTypingGame()),
    );
    setState(() {
      completedLevels[level - 1] = true;
    });
  }
}
