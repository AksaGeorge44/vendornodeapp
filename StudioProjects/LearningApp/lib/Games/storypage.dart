import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  String? _selectedAnswer;
  String? _selectedAnswer1;
  String? _selectedAnswer2;
  String? _selectedAnswer3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Story'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Read the story below',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'There was once a hare who was friends with a tortoise. One day, he challenged the tortoise to a race. Seeing how slow the tortoise was going, the hare thought he’d win this easily. So, he took a nap while the tortoise kept on going. When the hare woke, he saw that the tortoise was already at the finish line. Much to his chagrin, the tortoise won the race while he was busy sleeping.',
                  style: TextStyle(fontSize: 18,),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Answer the questions:',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '1. What animals were the main characters in the story?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Lion and Rabbit'),
              leading: Radio<String>(
                value: 'Lion and Rabbit',
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Hare and Tortoise'),
              leading: Radio<String>(
                value: 'Hare and Tortoise',
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Cat and Dog'),
              leading: Radio<String>(
                value: 'Cat and Dog',
                groupValue: _selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              '2. What did the hare challenge the tortoise to?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('A Race'),
              leading: Radio<String>(
                value: 'A race',
                groupValue: _selectedAnswer1,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer1 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Eating Game'),
              leading: Radio<String>(
                value: 'Eating Game',
                groupValue: _selectedAnswer1,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer1=value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Sleeping challenge'),
              leading: Radio<String>(
                value: 'Sleeping challenge',
                groupValue: _selectedAnswer1,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer1=value;
                  });
                },
              ),

            ),
            const SizedBox(height: 16.0),
            const Text(
              '3. What did the hare do during the race?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('The hare was eating food'),
              leading: Radio<String>(
                value: 'The hare was eating food',
                groupValue: _selectedAnswer2,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer2 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('The hare took a nap while the tortoise kept on going.'),
              leading: Radio<String>(
                value: 'The hare took a nap while the tortoise kept on going.',
                groupValue: _selectedAnswer2,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer2=value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('The hare was busy with talking to friends'),
              leading: Radio<String>(
                value: 'The hare was busy with talking to friends',
                groupValue: _selectedAnswer2,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer2=value;
                  });
                },
              ),

            ),
            const SizedBox(height: 16.0),
            const Text(
              '4. Who won the race?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Tortoise'),
              leading: Radio<String>(
                value: 'Tortoise',
                groupValue: _selectedAnswer3,
                onChanged: (value) {
                  setState(() {
                    _selectedAnswer3 = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Rabbit'),
              leading: Radio<String>(
                value: 'Rabbit',
                groupValue: _selectedAnswer3,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer3=value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Cat'),
              leading: Radio<String>(
                value: 'The hare was busy with talking to friends',
                groupValue: _selectedAnswer3,
                onChanged: (value){
                  setState(() {
                    _selectedAnswer3=value;
                  });
                },
              ),

            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int score = 0;
                if (_selectedAnswer == 'Hare and Tortoise') {
                  score++;
                }
                if (_selectedAnswer1 == 'A race') {
                  score++;
                }
                if(_selectedAnswer2 == 'The hare took a nap while the tortoise kept on going.')
                  {
                    score++;
                  }
                if(_selectedAnswer3 == 'Tortoise')
                  {
                    score++;
                  }

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Score'),
                      content: Text('Your score is: $score out of 5'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
