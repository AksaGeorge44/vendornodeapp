import 'package:flutter/material.dart';

class DaysMonthsScreen extends StatelessWidget {
  final List<String> daysOfWeek = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December',
  ];

  DaysMonthsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Days and Months'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Days', daysOfWeek, 3),
            const SizedBox(height: 40),
            _buildSection('Months', months, 3),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items, int itemsPerRow) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            for (var item in items) ...[
              _buildGridItem(item),
              if ((items.indexOf(item) + 1) % itemsPerRow == 0 &&
                  items.indexOf(item) != items.length - 1)
                const SizedBox(width: 1), // Adjust spacing between items in a row
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildGridItem(String itemName) {
    return Card(
      color: Colors.lightBlue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Add any interaction you want when the item is tapped
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            itemName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
