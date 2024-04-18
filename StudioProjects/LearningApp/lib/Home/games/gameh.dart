import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/Learn/colors.dart';
import 'package:learningapp/Learn/fruits.dart';

import '../../Games/VocaGameList/gramlstpage.dart';
import '../../Games/VocaGameList/vocgamelist.dart';


class GameHomePage extends StatefulWidget {
  const GameHomePage({super.key});

  @override
  State<GameHomePage> createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Games'),
          backgroundColor: Colors.blueAccent,
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'profile') {
                  // Handle profile option
                } else if (value == 'score') {
                  // Handle score option
                } else if (value == 'logout') {
                  // Handle logout option
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(value: 'profile', child: Text('Profile')),
                  const PopupMenuItem(value: 'score', child: Text('Score')),
                  const PopupMenuItem(value: 'logout', child: Text('Logout')),
                ];
              },
            ),
          ],
        ),
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Learn English Easily:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CarouselSlider(items: [
                Container(
                  height: 500,
                  width: 500,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://s3.envato.com/files/455212700/ss8.png'),
                          fit: BoxFit.contain)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsWDbldycXu154hXltIZOSpznIYDZqB4SBzQ&usqp=CAU'),
                          fit: BoxFit.contain)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://www.iphoneglance.com/wp-content/uploads/2021/05/dela-kids-slika.png'),
                          fit: BoxFit.contain)),
                ),
              ],
                  options: CarouselOptions()),
              const SizedBox(height: 20,),
              const Text(
                'Select Gaming Category:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildGameCategoryCard(
                      context,
                      'Vocabulary',
                      'Learn vocabulary',),
                    _buildGameCategoryCard(
                      context,
                      'Phonetics',
                      'Interactive games for improving grammar',),
                    _buildGameCategoryCard(
                      context,
                      'Grammar',
                      'Interactive games for improving grammar',),
                    _buildGameCategoryCard(
                      context,
                      'Reading',
                      'Learn and practice correct pronunciation',),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  }

Widget _buildGameCategoryCard(
    BuildContext context,
    String categoryTitle,
    String categoryDescription,
    ) {
  return GestureDetector(
    onTap: () {
      if (categoryTitle == 'Vocabulary') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VocabularyGameListPage(),
          ),
        );
      } else if (categoryTitle == 'Grammar') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GrammarGameListPage(),
          ),
        );
      } else if (categoryTitle == 'Phonetics') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FruitsScreen(),
          ),
        );
      } else if (categoryTitle == 'Reading') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LearnScreen(),
          ),
        );
      }
    },
    child: Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.gamepad, size: 50, color: Colors.blue),
          const SizedBox(height: 10),
          Text(
            categoryTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            categoryDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    ),
  );
}

