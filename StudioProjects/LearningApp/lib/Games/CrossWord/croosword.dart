import 'package:flutter/material.dart';

class CrosswordPuzzleGame extends StatelessWidget {
  final List<String> acrossClues = [
    '1. A place where people live',
    '2. A liquid that falls from the sky',
    // Add more clues as needed
  ];

  final List<String> downClues = [
    '1. A furry animal with a long tail',
    '2. Something that gives off light in the dark',
    // Add more clues as needed
  ];

  final List<List<String>> grid = [
    ['H', '', 'U', '', 'E'], // Example: "HOUSE"
    // Add more rows as needed
  ];

  List<List<TextEditingController>> controllers = [];

  @override
  Widget build(BuildContext context) {
    // Initialize text controllers for each cell
    for (int i = 0; i < grid.length; i++) {
      List<TextEditingController> rowControllers = [];
      for (int j = 0; j < grid[i].length; j++) {
        rowControllers.add(TextEditingController());
      }
      controllers.add(rowControllers);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Crossword Puzzle Game'),
      ),
      body: Column(
        children: [
          // Clues
          _buildCluesSection(),
          SizedBox(height: 16),
          // Crossword grid
          _buildCrosswordGrid(),
        ],
      ),
    );
  }

  Widget _buildCluesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Across',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        for (var clue in acrossClues) Text(clue),
        SizedBox(height: 16),
        Text(
          'Down',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        for (var clue in downClues) Text(clue),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCrosswordGrid() {
    return Table(
      border: TableBorder.all(),
      children: [
        for (int i = 0; i < grid.length; i++)
          TableRow(
            children: [
              for (int j = 0; j < grid[i].length; j++)
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: TextField(
                        controller: controllers[i][j],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        readOnly: grid[i][j] != '',
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

