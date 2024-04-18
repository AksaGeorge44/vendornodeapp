import 'dart:math';
import 'package:flutter/material.dart';

class WordSearchScreen extends StatefulWidget {
  @override
  _WordSearchScreenState createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  final List<String> wordsToFind = ['CAT', 'DOG', 'PEN', 'CAR'];
  late List<List<String>> grid;
  int score = 0;
  String currentWord = '';
  Set<int> selectedIndices = {};

  @override
  void initState() {
    super.initState();
    grid = generateGrid(wordsToFind);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Search Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: grid.length * grid.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid.length,
                ),
                itemBuilder: (BuildContext context, int index) {
                  int row = index ~/ grid.length;
                  int col = index % grid.length;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIndices.contains(index)) {
                          selectedIndices.remove(index);
                          currentWord = currentWord.replaceAll(grid[row][col], '');
                        } else {
                          selectedIndices.add(index);
                          currentWord += grid[row][col];
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: selectedIndices.contains(index) ? Colors.blue : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          grid[row][col],
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Find Words: ${wordsToFind.join(', ')}', style: TextStyle(fontSize: 24)),
            Text('Current Word: $currentWord', style: TextStyle(fontSize: 20)),
            Text('Score: $score', style: TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () {
                if (wordsToFind.contains(currentWord)) {
                  setState(() {
                    score++;
                    wordsToFind.remove(currentWord);
                    currentWord = '';
                    selectedIndices.clear();
                  });
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

List<List<String>> generateGrid(List<String> wordsToFind) {
  final List<String> letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
  final Random random = Random();
  final List<List<String>> grid = [];

  for (int i = 0; i < 8; i++) {
    final List<String> row = [];
    for (int j = 0; j < 8; j++) {
      row.add('');
    }
    grid.add(row);
  }

  for (final word in wordsToFind) {
    final bool horizontal = random.nextBool();
    int row, col;
    if (horizontal) {
      row = random.nextInt(8);
      col = random.nextInt(8 - word.length + 1);
      for (int i = 0; i < word.length; i++) {
        grid[row][col + i] = word[i];
      }
    } else {
      row = random.nextInt(8 - word.length + 1);
      col = random.nextInt(8);
      for (int i = 0; i < word.length; i++) {
        grid[row + i][col] = word[i];
      }
    }
  }

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (grid[i][j] == '') {
        final randomIndex = random.nextInt(letters.length);
        grid[i][j] = letters[randomIndex];
      }
    }
  }
  return grid;
}
