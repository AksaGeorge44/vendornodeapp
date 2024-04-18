import 'package:flutter/material.dart';

class AnimalPage extends StatefulWidget {
  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  //FlutterTts flutterTts = FlutterTts();
  int currentAnimalIndex = 0;

  List<Animal> animalList = [
    Animal(name: "Dog", image: "assets/images/dog.png"),
    Animal(name: "Giraffe", image: "assets/images/zebra.png"),
    Animal(name: "Fox", image: "assets/images/fox.jpg")
    // Add more animals as needed
  ];

  double speechRate = 0.5;

  void speakAnimalName(String animalName) async {
    // await flutterTts.setLanguage("en-US");
    // await flutterTts.setSpeechRate(speechRate); // Set the speech rate
    // await flutterTts.speak(animalName);
  }

  void nextAnimal() {
    setState(() {
      currentAnimalIndex = (currentAnimalIndex + 1) % animalList.length;
    });
  }

  void previousAnimal() {
    setState(() {
      currentAnimalIndex =
          (currentAnimalIndex - 1 + animalList.length) % animalList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Animal currentAnimal = animalList[currentAnimalIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animal Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(currentAnimal.image, height: 200, width: 200),
            SizedBox(height: 20),
            Text(
              currentAnimal.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                speakAnimalName(currentAnimal.name);
              },
              child: Text('Speak Animal Name'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: previousAnimal,
                  icon: Icon(Icons.arrow_circle_left_outlined, size: 60),
                ),
                IconButton(
                  onPressed: nextAnimal,
                  icon: Icon(Icons.arrow_circle_right_outlined, size: 60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Animal {
  final String name;
  final String image;

  Animal({required this.name, required this.image});
}
