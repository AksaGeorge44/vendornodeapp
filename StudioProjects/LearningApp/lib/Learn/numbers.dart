import 'package:flutter/material.dart';


class NumbersScreen extends StatelessWidget {
  final List<NumberItem> numbers = [
    NumberItem(number: 1, name: 'One'),
    NumberItem(number: 2, name: 'Two'),
    NumberItem(number: 3, name: 'Three'),
    NumberItem(number: 4, name: 'Four'),
    NumberItem(number: 5, name: 'Five'),
    NumberItem(number: 6, name: 'Six'),
    NumberItem(number: 7, name: 'Seven'),
    NumberItem(number: 8, name: 'Eight'),
    NumberItem(number: 9, name: 'Nine'),
    NumberItem(number: 10, name: 'Ten'),
  ];

   NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return _buildNumberCard(context, numbers[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, NumberItem numberItem) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 110,
            color: Colors.blue.shade400, // You can customize colors
            child: Center(
              child: Text(
                numberItem.number.toString(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              numberItem.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberItem {
  final int number;
  final String name;

  NumberItem({
    required this.number,
    required this.name,
  });
}
