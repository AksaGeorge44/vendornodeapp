import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learningapp/Games/levelSelection.dart';
import 'package:learningapp/GuessName/guessnames2.dart';

class GuessingGame1 extends StatefulWidget {
  const GuessingGame1({Key? key}) : super(key: key);

  @override
  _GuessingGame1State createState() => _GuessingGame1State();
}

class _GuessingGame1State extends State<GuessingGame1> {
  int score = 0;
  int totalPoints = 0;

  List<Animal> animals = [
    Animal(name: 'Lion', imagePath: 'assets/animals/lion.png', points: 1),
    Animal(name: 'Cat', imagePath: 'assets/animals/cat.png', points: 1),
  ];

  List<Animal> shuffledAnimals = [];

  List<List<Animal>> allAnimalCategories = [];

  int currentCategoryIndex = 0;

  bool showNextLevelButton = false;
  bool gamePlayed = false; // Flag to track if the game has been played

  @override
  void initState() {
    super.initState();
    allAnimalCategories.add(animals);
    // Load the game state
    _loadGameState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level 1'),
        backgroundColor: Colors.blue.shade200,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: shuffledAnimals.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimalCard(
                    animal: shuffledAnimals[index],
                    onMatched: () {
                      setState(() {
                        if (!gamePlayed) {
                          score += shuffledAnimals[index].points!;
                          totalPoints += shuffledAnimals[index].points!;
                          shuffledAnimals[index].matched = true;

                          // Check if all animals are matched
                          if (shuffledAnimals.every((animal) => animal.matched)) {
                            _showGameCompletedDialog();
                          }

                          // Save game state
                          _saveGameState();
                        }
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 50,),
              Text('Score: $score', style: const TextStyle(fontSize: 30)),

              if (showNextLevelButton)
                Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => LevelSelection()));
                        },
                        child: const Text("Home"),
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => GuessingGame2()));
                        },
                        child: const Text("Next Level"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Load game state
  void _loadGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      score = prefs.getInt('score') ?? 0;
      totalPoints = prefs.getInt('totalPoints') ?? 0;
      currentCategoryIndex = prefs.getInt('currentCategoryIndex') ?? 0;
      shuffledAnimals = List<Animal>.from(allAnimalCategories[currentCategoryIndex]);
      showNextLevelButton = prefs.getBool('showNextLevelButton') ?? false;
      gamePlayed = prefs.getBool('gamePlayed') ?? false; // Load gamePlayed flag
    });
  }

  // Save game state
  void _saveGameState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', score);
    prefs.setInt('totalPoints', totalPoints);
    prefs.setInt('currentCategoryIndex', currentCategoryIndex);
    prefs.setBool('showNextLevelButton', showNextLevelButton);
    prefs.setBool('gamePlayed', true); // Save gamePlayed flag
  }

  void _showGameCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        totalPoints += score;
        return AlertDialog(
          title: const Text('Level 1 Completed'),
          content: Text('Congratulations! Your total score: $totalPoints'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showNextLevelButton();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showNextLevelButton() {
    setState(() {
      showNextLevelButton = true;
    });
  }
}

class Animal {
  final String name;
  final String imagePath;
  final int? points;
  bool matched;

  Animal({
    required this.name,
    required this.imagePath,
    this.points,
    this.matched = false,
  });
}

class AnimalCard extends StatefulWidget {
  final Animal animal;
  final Function() onMatched;

  AnimalCard({Key? key, required this.animal, required this.onMatched}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  TextEditingController textEditingController = TextEditingController();
  String typedName = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.animal.matched) {
          _showAnimalNameDialog(context);
        }
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.animal.matched ? widget.animal.imagePath : widget.animal.imagePath,
                height: 100,
                width: 80,
              ),
            ),
            if (typedName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$typedName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAnimalNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(26.0),
            child: const Text('Guess the animal?'),
          ),
          content: Column(
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: textEditingController,
                onChanged: (value) {
                  setState(() {
                    typedName = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Type the animal name',
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  String enteredName = typedName.trim();
                  if (enteredName.isNotEmpty &&
                      enteredName.toLowerCase() == widget.animal.name.toLowerCase()) {
                    Navigator.pop(context);
                    widget.onMatched();
                  } else {
                    _showIncorrectGuessDialog(context);
                  }
                },
                child: const Text('Match'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showIncorrectGuessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong Guess'),
          content: const Text('Incorrect guess! Please try again.'),
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
