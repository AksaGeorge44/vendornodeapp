import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/fill3.dart';
import 'package:learningapp/levelFill4.dart';
import '../../fill2.dart';


class LevelFill extends StatefulWidget {
  const LevelFill({super.key});

  @override
  State<LevelFill> createState() => _LevelFillState();
}

class _LevelFillState extends State<LevelFill> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    _getStoredScore();
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

  List<Fill> values = [
    Fill(name: "1"),
    Fill(name: "2"),
    Fill(name: "3"),
    Fill(name: "4"),
    Fill(name: "5"),
    Fill(name: "6"),
    Fill(name: "7"),
    Fill(name: "8"),
    Fill(name: "9"),
    Fill(name: "10"),
    Fill(name: "11"),
    Fill(name: "12"),
    Fill(name: "13"),
    Fill(name: "14"),
    Fill(name: "15"),
    Fill(name: "16"),
    Fill(name: "17"),
    Fill(name: "18"),
    Fill(name: "19"),
    Fill(name: "20"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemCount: values.length,
              itemBuilder: (context, index){
                return fillcard(context, values[index]);
              },
            ),
          ),
          // SizedBox(height: 40,),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Game1()));
          //   },
          //   child: Text("Game Page"),
          // ),
        ],
      ),
    );
  }

  Widget fillcard(BuildContext context, Fill val) {
    bool isUnlocked = val.name == "1" || int.parse(val.name) <= score+1; // Level 1 or score high enough

    Color? cardColor = isUnlocked ? Colors.blue.shade100 : Colors.grey.shade100;
    Text(
      val.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: isUnlocked ? Colors.black : Colors.grey, // Text color based on unlocked status
      ),
    );
    return GestureDetector(
      onTap: () {
        if (isUnlocked) {
          // Navigate to the level screen based on val.name
          switch (val.name) {
            case '1':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill1()));
              break;
            case '2':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill2()));
              break;
            case '3':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill3()));
              break;
            case '4':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill4()));
              break;
            case '5':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill1()));
              break;
            case '6':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill1()));
              break;
            case '7':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill1()));
              break;
            case '8':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill2()));
              break;
            case '9':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill2()));
              break;
            case '10':
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Fill2()));
              break;
            default:
              break;
          }
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Level Locked'),
                content: const Text('This level is locked. You need to complete previous level to unlock it.'),
                actions: [
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
        }
      },
      child: Card(
        elevation: 3,
        color: cardColor, // Assigning the card color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                val.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: isUnlocked ? Colors.black : Colors.grey, // Text color based on unlocked status
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

class Fill{
  final String name;

  Fill({required this.name});
}


class Fill1 extends StatefulWidget {
  const Fill1({super.key});

  @override
  State<Fill1> createState() => _Fill1State();
}

class _Fill1State extends State<Fill1> {
  final TextEditingController _controller = TextEditingController();
  String _answer = '';
  bool _answeredCorrectly = false;
  int score = 0;

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
        title: const Text("Level 1"),
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
              "assets/animals/cat.png",
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "C",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 30,
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _answer = value.toUpperCase();
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
                  "T",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _answeredCorrectly
                ? Column(
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   child: Text('Go Back to Home'),
                // ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const Fill2(),
                      ),
                    );
                  },
                  child: const Text('Next Level'),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                if (!_answeredCorrectly && _answer == 'A') {
                  setState(() {
                    _answeredCorrectly = true;
                    score = 1; // Score becomes 1 on correct answer
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
                Navigator.pop(context);
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
    if (score == 1) {
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







