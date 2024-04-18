import 'package:flutter/material.dart';


class WordSearchHomePage extends StatelessWidget {
  final List<String> words = [
    'APPLE',
    'BANANA',
    'ORANGE',
    'GRAPES',
    'MANGO',
  ];

  final List<String> grid = [
    'APPLR',
    'NANAQ',
    'ORANG',
    'GRAPE',
    'MANGO',
  ];

   WordSearchHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Search - Vocabulary Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Find the following words:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid.length,
                ),
                itemCount: grid.length * grid.length,
                itemBuilder: (context, index) {
                  int row = index ~/ grid.length;
                  int col = index % grid.length;
                  String letter = grid[row][col];
                  return Cell(letter: letter);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  final String letter;

  const Cell({Key? key, required this.letter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        letter,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
