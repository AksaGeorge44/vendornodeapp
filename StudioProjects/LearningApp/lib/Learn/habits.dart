import 'package:flutter/material.dart';

class DailyHabitsScreen extends StatelessWidget {
  final List<HabitItem> habits = [
    HabitItem(imagePath: 'assets/images/eating.png', text: 'Eating'),
    HabitItem(imagePath: 'assets/images/reading.png', text: 'Reading'),
    HabitItem(imagePath: 'assets/images/exercise.png', text: 'Exercise'),
    HabitItem(imagePath: 'assets/images/sleeping.png', text: 'Sleeping'),
  ];

   DailyHabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Habits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16.3
          ),
          itemCount: habits.length,
          itemBuilder: (context, index) {
            return _buildHabitCard(context, habits[index]);
          },
        ),
      ),
    );
  }

  Widget _buildHabitCard(BuildContext context, HabitItem habit) {
    return Card(
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(habit.imagePath, height: 100, width: 120),
          ), // Adjust the size as needed
          const SizedBox(height: 10),
          Text(
            habit.text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


}

class HabitItem {
  final String imagePath;
  final String text;

  HabitItem({required this.imagePath, required this.text});
}
