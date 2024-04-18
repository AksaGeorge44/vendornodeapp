import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  String prediction = 'Loading...';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController openingValueController = TextEditingController();
  final TextEditingController highPriceController = TextEditingController();
  final TextEditingController lowPriceController = TextEditingController();
  final TextEditingController closePriceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();

  Future<void> fetchBitcoinPrediction() async {
    try {
      // Prepare data for prediction
      Map<String, dynamic> data = {
        'name': nameController.text,
        'Opening Value': openingValueController.text,
        'High Price': highPriceController.text,
        'Low Price': lowPriceController.text,
        'Close Price': closePriceController.text,
        'Volume': volumeController.text,
        'Year': yearController.text,
        'Month': monthController.text,
      };

      final response = await http.post(
        Uri.parse('http://192.168.0.189:8000/predict_now/'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10)); // Adjust the timeout duration as needed


      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          prediction = responseData['prediction'];
        });
      } else {
        throw Exception('Failed to load prediction');
      }
    } catch (error) {
      setState(() {
        prediction = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: openingValueController,
                decoration: InputDecoration(labelText: 'Opening Value'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: highPriceController,
                decoration: InputDecoration(labelText: 'High Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: lowPriceController,
                decoration: InputDecoration(labelText: 'Low Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: closePriceController,
                decoration: InputDecoration(labelText: 'Close Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: volumeController,
                decoration: InputDecoration(labelText: 'Volume'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: monthController,
                decoration: InputDecoration(labelText: 'Month'),
               // keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchBitcoinPrediction,
                child: Text('Predict'),
              ),
              SizedBox(height: 20),
              Text(
                'Prediction: $prediction',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
