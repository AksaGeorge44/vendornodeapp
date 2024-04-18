import 'package:flutter/material.dart';

class FillName extends StatefulWidget {
  const FillName({Key? key});

  @override
  State<FillName> createState() => _FillNameState();
}

class _FillNameState extends State<FillName> {
  List<AnimalId> animals = [
    AnimalId(name: 'Cat', image: 'assets/images/cat.png'),
    AnimalId(name: 'Dog', image: 'assets/images/dog.png'),
    AnimalId(name: 'Goat', image: 'assets/images/goat.png'),
  ];
  List<AnimalId> shuffledAnimal = [];
  int score = 0;
  int matchedCount = 0;
  bool isGameCompleted = false;

  @override
  void initState() {
    super.initState();
    shuffledAnimal = List.from(animals)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill letters"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 16,
                ),
                itemCount: shuffledAnimal.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AnimalCard(
                    animal: shuffledAnimal[index],
                    onMatched: () {
                      setState(() {
                        score += 1;
                        shuffledAnimal[index].matched = true;
                        matchedCount++;
                        if (matchedCount == shuffledAnimal.length) {
                          isGameCompleted = true;
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 50,),
            Text("Score: $score",style: const TextStyle(
                fontSize: 25
            ),),
            if (isGameCompleted)
              ElevatedButton(
                onPressed: showGame,
                child: const Text('Done'),
              ),
          ],
        ),
      ),
    );
  }

  void showGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Game completed"),
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

class AnimalId {
  final String name;
  final String image;
  bool matched;

  AnimalId({required this.name, required this.image, this.matched = false});
}

class AnimalCard extends StatefulWidget {
  final AnimalId animal;
  final Function() onMatched;
  AnimalCard({Key? key, required this.animal, required this.onMatched})
      : super(key: key);

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  late String typedName = ''; // Declare typedName variable here

  late String maskedName;

  @override
  void initState() {
    super.initState();
    maskedName = _generateMaskedName(widget.animal.name);
  }

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
            Image.asset(
              widget.animal.matched ? widget.animal.image : widget.animal.image,
              height: 100,
              width: 150,
            ),
            const SizedBox(height: 8),
            Text(
              maskedName,
              style: const TextStyle(fontSize: 18),
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
          title: const Text("Guess Animal"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Fill the missing letter: ${maskedName.replaceAll("_", "")}",
                style: const TextStyle(fontSize: 18),
              ),
              TextField(
                maxLength: 1, // Set max length to 1 character
                onChanged: (value) {
                  setState(() {
                    typedName = value.trim().toLowerCase();
                    maskedName = _generateMaskedName(widget.animal.name);
                  });
                },
                decoration: const InputDecoration(hintText: "Type the missing letter"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (typedName.isNotEmpty && typedName == widget.animal.name.trim().toLowerCase()) {
                    widget.onMatched();
                  }
                  Navigator.pop(context);
                },
                child: const Text("Done"),
              ),
            ],
          ),
        );
      },
    );
  }

  String _generateMaskedName(String name) {
    String maskedName = '';
    for (int i = 0; i < name.length; i++) {
      if (name[i] == ' ') {
        maskedName += ' ';
      } else if (i == 0 || i == name.length - 1) {
        maskedName += name[i];
      } else {
        maskedName += typedName.length > i && typedName[i].toLowerCase() == name[i].toLowerCase() ? name[i] : '_';
      }
    }
    return maskedName;
  }

}
