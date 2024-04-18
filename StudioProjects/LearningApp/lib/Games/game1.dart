import 'package:flutter/material.dart';

class Match1 extends StatefulWidget {
  const Match1({super.key});

  @override
  _Match1State createState() => _Match1State();
}

class _Match1State extends State<Match1> {

  List<List<Animal>> animalSets = [
    [
      Animal(name: 'lion', imagePath: 'assets/animals/lion.png'),
      Animal(name: 'dog', imagePath: 'assets/animals/dog.png'),
      Animal(name: 'cat', imagePath: 'assets/animals/cat.png'),
      Animal(name: 'fox', imagePath: 'assets/animals/fox.png'),
    ],
  ];

  int currentSetIndex = 0;
  late List<Animal> currentAnimals; // Original animal list
  late List<String> shuffledNames; // Shuffled list of animal names
  Map<String, GlobalKey> imageKeys = {};
  Map<String, GlobalKey> nameKeys = {};
  Map<String, bool> answerStatus = {};
  int totalPoints = 0;

  @override
  void initState() {
    super.initState();
    currentAnimals = animalSets[currentSetIndex];
    shuffledNames = currentAnimals.map((animal) => animal.name).toList()..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match'),
        backgroundColor: Colors.blue.shade200,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                shuffledNames.shuffle(); // Shuffle names only
                answerStatus.clear(); // Reset answer status on shuffle
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.calculate),
            onPressed: () {
              _showTotalPoints(totalPoints);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: currentAnimals.length,
                itemBuilder: (BuildContext context, int index) {
                  Animal animal = currentAnimals[index];
                  return Row(
                    children: [
                      Expanded(
                        child: buildAnimal(animal),
                      ),
                      Expanded(
                        child: buildAnimalName(shuffledNames[index]),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(68.0),
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswers();
                },
                child: const Text('Check Answers'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimal(Animal animal) {
    return DragTarget<String>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          answerStatus[animal.name] = data == animal.name;
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            Container(
              key: imageKeys[animal.name],
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.transparent,
                child: Image.asset(
                  animal.imagePath,
                  height: 100,
                  width: 120,
                ),
              ),
            ),
            if (answerStatus[animal.name] == true)
              Positioned.fill(
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget buildAnimalName(String name) {
    return Draggable<String>(
      data: name,
      child: Container(
        key: nameKeys[name] ?? GlobalKey(),
        padding: const EdgeInsets.all(8.0),
        color: answerStatus[name] ?? false ? Colors.green : Colors.transparent,
        child: Text(
          name,
          style: const TextStyle(fontSize: 29),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.transparent, // Make invisible while dragging
      ),
      feedback: Text(
        name,
        style: TextStyle(
          fontSize: 29,
          color: Colors.grey.shade700, // Faded color while dragging
        ),
      ),
    );
  }


  void _checkAnswers() {
    int correctAnswers = 0;

    for (Animal animal in currentAnimals) {
      String animalName = animal.name;
      String imageName = animal.imagePath.split('/').last.split('.').first;

      if (answerStatus[animalName] == true && animalName == imageName) {
        correctAnswers++;
      }

      if (answerStatus[imageName] == true && imageName == animalName) {
        correctAnswers++;
      }
    }

    int pointsEarned = (correctAnswers / (currentAnimals.length * 2) * 4).toInt();
    totalPoints += pointsEarned;
    _showGameCompletedDialog("Congratulations! You earned $pointsEarned points in this game.");
  }

  void _showGameCompletedDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Completed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _showTotalPoints(int points) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Points'),
          content: Text("Your total points: $points"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Animal {
  String name;
  final String imagePath;
  Animal({required this.name, required this.imagePath});
}



