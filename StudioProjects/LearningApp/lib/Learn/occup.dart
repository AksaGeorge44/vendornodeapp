import 'package:flutter/material.dart';

class OccupationsScreen extends StatelessWidget {
  final List<OccupationItem> occupations = [
    OccupationItem(
      imagePath: 'assets/images/doctor.png',
      title: 'Doctor',
      description: 'Helps people stay healthy and treats illnesses.',
    ),
    OccupationItem(
      imagePath: 'assets/images/firefighter.png',
      title: 'Firefighter',
      description: 'Brave individuals who fight fires and save lives.',
    ),
    OccupationItem(
      imagePath: 'assets/images/teacher.png',
      title: 'Teacher',
      description: 'Educates and guides students to learn new things.',
    ),
    OccupationItem(
      imagePath: 'assets/images/astronaut.png',
      title: 'Astronaut',
      description: 'Explores space and travels to other planets.',
    ),
  ];

   OccupationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: occupations.length,
          itemBuilder: (context, index) {
            return _buildOccupationCard(context, occupations[index]);
          },
        ),
      ),
    );
  }

  Widget _buildOccupationCard(BuildContext context, OccupationItem occupation) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(occupation.imagePath, height: 150, fit: BoxFit.contain),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    occupation.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    occupation.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OccupationItem {
  final String imagePath;
  final String title;
  final String description;

  OccupationItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
