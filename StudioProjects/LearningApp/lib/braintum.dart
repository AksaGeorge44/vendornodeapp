import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PredictApp extends StatefulWidget {
  @override
  State<PredictApp> createState() => _PredictAppState();
}

class _PredictAppState extends State<PredictApp> {
  File? _imageFile;
  String _prediction = "";

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> makePrediction() async {
    if (_imageFile == null) {
      return;
    }

    const String apiUrl = 'http://192.168.0.106:8000/predict_now/';

    final multipartRequest = http.MultipartRequest('POST', Uri.parse(apiUrl));
    multipartRequest.fields['image'] = _imageFile!.path;

    try {
      final response = await multipartRequest.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.transform(utf8.decoder).join();
        final prediction = jsonDecode(responseData)['prediction'];
        setState(() {
          _prediction = prediction;
        });
        print("Server result: $prediction");
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brain Tumor Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image selection button
            ElevatedButton(
              onPressed: pickImage,
              child: Text('Select Image'),
            ),

            if (_imageFile != null)
              Image.file(_imageFile!),

            // Prediction text
            Text(_prediction),

            ElevatedButton(
              onPressed: makePrediction,
              child: Text('Predict'),
            ),
          ],
        ),
      ),
    );
  }
}
