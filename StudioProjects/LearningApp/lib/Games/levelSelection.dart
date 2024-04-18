import 'package:flutter/material.dart';
import 'package:learningapp/Games/subscription.dart';
import 'package:learningapp/GuessName/guessname.dart';
import 'package:learningapp/GuessName/guessname1.dart';
import 'package:learningapp/GuessName/guessnames2.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Level:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: List.generate(
                  10, // Number of levels
                      (index) {
                    int levelNumber = index + 1;
                    return GestureDetector(
                      onTap: () {
                        if (levelNumber <= 3) {
                          _navigateToGame(context, levelNumber);
                        } else {
                          _showSubscriptionDialog(context);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: levelNumber <= 3 ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            'Level $levelNumber',
                            style: const TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(BuildContext context, int levelNumber) {
    switch (levelNumber) {
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GuessingGame()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GuessingGame1()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GuessingGame2()));
        break;
      default:
        break;
    }
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Subscription Required'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Unlock this game by subscribing to our premium plan.'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SubscriptionDemoPage()));
                },
                child: const Text('Subscribe'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }
}
