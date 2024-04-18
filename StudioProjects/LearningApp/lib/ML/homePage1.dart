import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ObjectDetectionScreen extends StatefulWidget {
  @override
  _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  List<dynamic> _recognitions = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadResultsFromPrefs();
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224_quant.tflite",
      labels: "assets/labels_mobilenet_quant_v1_224.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  Future<void> detectObjectsOnImage(File imageFile) async {
    var recognitions = await Tflite.detectObjectOnImage(
      path: imageFile.path, // Pass the file path here
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.4,
      numResultsPerClass: 2,
      asynch: true,
    );
    setState(() {
      _recognitions = recognitions!;
    });
    _saveResultsToPrefs(recognitions!);
  }

  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      detectObjectsOnImage(imageFile);
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      detectObjectsOnImage(imageFile);
    }
  }

  Future<void> _loadResultsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? results = prefs.getStringList('object_detection_results');
    if (results != null) {
      setState(() {
        _recognitions =
            results.map((result) => Map<String, dynamic>.from(json.decode(result))).toList();
      });
    }
  }

  Future<void> _saveResultsToPrefs(List<dynamic> recognitions) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> results =
    recognitions.map((recognition) => json.encode(recognition)).toList();
    prefs.setStringList('object_detection_results', results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object Detection'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _getImageFromGallery,
            child: Text("Select Image"),
          ),
          ElevatedButton(
            onPressed: _getImageFromCamera,
            child: Text("Capture from Camera"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recognitions.length,
              itemBuilder: (context, index) {
                var recognition = _recognitions[index];
                return ListTile(
                  title: Text('Class: ${recognition['detectedClass']}'),
                  subtitle: Text('Confidence: ${recognition['confidenceInClass']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
