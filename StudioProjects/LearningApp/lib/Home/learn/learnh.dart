import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/Learn/animals.dart';
import 'package:learningapp/Learn/bodyparts.dart';
import 'package:learningapp/Learn/colors.dart';
import 'package:learningapp/Learn/days.dart';
import 'package:learningapp/Learn/fruits.dart';
import 'package:learningapp/Learn/habits.dart';
import 'package:learningapp/Learn/numbers.dart';
import 'package:learningapp/Learn/occup.dart';
import 'package:learningapp/Learn/shapes.dart';

class LearningHomePage extends StatefulWidget {
  const LearningHomePage({super.key});

  @override
  State<LearningHomePage> createState() => _LearningHomePageState();
}

class _LearningHomePageState extends State<LearningHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
         // title: const Text('Language'),
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
              const SizedBox(height: 15),
              CarouselSlider(items: [
                Container(
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
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false, )),
              SizedBox(height: 20,),
              const Text(
                'Learning:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 2,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildLearnCategoryCard(context, 'Days', 'Learn days and months',),
                    _buildLearnCategoryCard(context, 'Habits', 'Daily habits',),
                    _buildLearnCategoryCard(context, 'Fruits', 'Learn names of fruits',),
                    _buildLearnCategoryCard(context, 'Colours', 'Learn names of colours',),
                    _buildLearnCategoryCard(context, 'Shapes', 'Learn shapes'),
                    _buildLearnCategoryCard(context, 'Numbers', 'Learn numbers'),
                    _buildLearnCategoryCard(context, 'Animals', 'Animals'),
                    _buildLearnCategoryCard(context, 'Jobs', 'Occupations'),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearnCategoryCard(
      BuildContext context,
      String categoryTitle,
      String categoryDescription,
      ) {
    return GestureDetector(
      onTap: () {
        if (categoryTitle == 'Days') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DaysMonthsScreen(),
            ),
          );
        } else if (categoryTitle == 'Habits') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DailyHabitsScreen(),
            ),
          );
        } else if (categoryTitle == 'Fruits') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FruitsScreen(),
            ),
          );
        } else if (categoryTitle == 'Colours') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LearnScreen(),
            ),
          );
        } else if (categoryTitle == 'Jobs') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OccupationsScreen(),
            ),
          );
        } else if (categoryTitle == 'BodyParts') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BodyPartsScreen(),
            ),
          );
        }
        else if (categoryTitle == 'Shapes') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShapesScreen(),
            ),
          );
        }
        else if (categoryTitle == 'Numbers') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NumbersScreen(),
            ),
          );
        }
        else if (categoryTitle == 'Animals') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalPage(),
            ),
          );
        }
      },
      child: Card(
        // elevation: 3,
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
}



