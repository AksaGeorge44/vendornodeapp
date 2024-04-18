import 'package:flutter/material.dart';

class FindItemWidget extends StatefulWidget {
  const FindItemWidget({super.key});

  @override
  _FindItemWidgetState createState() => _FindItemWidgetState();
}

class _FindItemWidgetState extends State<FindItemWidget> {
  int currentItemIndex = 0;
  List<String> items = ['apple', 'aeroplane','banana', 'orange','zebra','chicken','carrot'];
  List<String> hints = [
    '\nThis is a popular fruit.\nThis item is Red and Juicy.',
    '\nThis carries lots of people.\nAs it’s a mode of transport.\nYou can see a lot of these,if you go to an airport.',
    '\nIt is a Fruit.\nThis item is yellow when ripe and crescent-shaped.',
    '\nThis item is orange and has a citrusy taste.',
    '\nThis is something black and white.\nbut it’s not an old TV.\nit’s a type of animal.\nthat starts with the letter Z',
    '\nYou can eat its wings,\nIts breast and its legs,\nplus when it’s alive\nyou can eat its eggs',
    '\nBuying this vegetable\ndoesn’t cost much money\nit is the favorite food\nof the great Bugs Bunny',
  ];
  String enteredItem = '';
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Find Item'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Hint:',style: TextStyle(fontSize: 25,)),

                 Text('${hints[currentItemIndex]}',style: TextStyle(fontSize: 20,)),
                const SizedBox(height: 40),
                TextFormField(
                  onChanged: (value) {
                    enteredItem = value.trim().toLowerCase();

                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter the item name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _checkItem();

                      },
                      child: const Text('Check'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _nextItem();
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
    );
  }

  void _checkItem() {
    String correctItem = items[currentItemIndex];
    if (enteredItem == correctItem) {
      setState(() {
        score++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Congratulations! You found the item!'),
            duration: Duration(seconds: 4),
          ),
        );
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Try again!'),
            duration: Duration(seconds: 4),
          ),
        );
      });
    }
  }

  void _nextItem() {
    setState(() {
      currentItemIndex = (currentItemIndex + 1) % items.length;
      enteredItem = '';
    });
  }

}
