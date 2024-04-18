
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Games/SentConst/levelSel.dart';

class Fill4 extends StatefulWidget {
  const Fill4({super.key});

  @override
  State<Fill4> createState() => _Fill4State();
}

class _Fill4State extends State<Fill4> {
  final TextEditingController _controller = TextEditingController();
  String _answer = '';
  bool _answeredCorrectly = false;
  int score = 0; // Initial score for level 2

  @override
  void initState() {
    super.initState();
    _getStoredScore();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Level 4"),
        backgroundColor: Colors.lightBlue.shade100,
        actions: [
          IconButton(
            onPressed: () {
              _showScoreDialog();
            },
            icon: const Icon(Icons.star),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/animals/dog.png", // Change the image path for level 2
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _answer = value.toUpperCase(); // Convert to uppercase
                        _controller.value = TextEditingValue(
                          text: _answer,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: _answer.length),
                          ),
                        );
                      });
                    },
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "O",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  "G",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _answeredCorrectly
                ? Column(
              children: [
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Fill1()));
                    // Proceed to next level logic
                  },
                  child: const Text('Next Level'),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                if (!_answeredCorrectly && _answer == 'D') {
                  setState(() {
                    _answeredCorrectly = true;
                    score = 2; // Score becomes 1 on correct answer
                    _updateScoreInFirebase();
                  });
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Correct!'),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                } else if (!_answeredCorrectly) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incorrect! Try again.'),
                      duration: Duration(milliseconds: 700),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 10,),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LevelFill()));
              },
              child: const Text('Go Back to Home'),
            ),
          ],
        ),
      ),
    );
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Score'),
          content: Text('Score: $score'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _updateScoreInFirebase() async {
    if (score == 2) {
      await Firebase.initializeApp();
      final DocumentReference documentReference =
      FirebaseFirestore.instance.collection('scores').doc('userScore');
      await documentReference.set({'score': score});
    }
  }

  void _getStoredScore() async {
    await Firebase.initializeApp();
    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection('scores').doc('userScore');
    final DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.exists) {
      setState(() {
        score = (snapshot.data() as Map<String, dynamic>)['score'];
      });
    }
  }
}