import 'package:flutter/material.dart';

class MyPredictionsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> predictions;

  MyPredictionsScreen({required this.predictions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Predictions'),
      ),
      body: predictions.isEmpty
          ? Center(child: Text('No predictions available'))
          : ListView.builder(
        itemCount: predictions.length,
        itemBuilder: (context, index) {
          final prediction = predictions[index];
          return ListTile(
            leading: Image.network(
              prediction['image'],
              width: 100,
            ),
            title: Text('Prediction ID: ${prediction['id']}'),
            subtitle: Text('Result: ${prediction['result']}'),
          );
        },
      ),
    );
  }
}
