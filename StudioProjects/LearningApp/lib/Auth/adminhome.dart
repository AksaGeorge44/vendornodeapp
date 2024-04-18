import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningapp/Games/CrossWord/croosword.dart';
import 'package:learningapp/Games/WordMatch/wordmatch.dart';

import 'addnewgame.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Homepage'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('games').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var gameName = doc['name'];
                      return ListTile(
                        title: Text(gameName),
                        subtitle: Text(doc['description']),
                        onTap: () {
                          _navigateToGamePage(context, gameName);
                        },
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewGamePage()),
              );
            },
            child: Text('Add New Game'),
          ),
        ],
      ),
    );
  }

  void _navigateToGamePage(BuildContext context, String gameName) {
    switch (gameName) {
      case 'Game 1':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CrosswordPuzzleGame()),
        );
        break;
      case 'Game 2':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WordMatchingGame()),
        );
        break;
      default:
        print('No page found for $gameName');
        break;
    }
  }
}