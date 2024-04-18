import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
import 'package:image/image.dart' as img;

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  File? _image;
  List? _output;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Detection"),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: const Text("Select Image"),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text("No image selected")
                : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _classifyImage,
              child: const Text("Submit"),
            ),
            SizedBox(height: 20),
            _output != null
                ? Column(
              children: _output!.map((e) {
                return Text("${e['label']} - ${(e['confidence'] * 100).toStringAsFixed(2)}%");
              }).toList(),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _classifyImage() async {
    if (_image == null) return;

    var interpreter =
    await Interpreter.fromAsset('assets/detect.tflite');
    var input = _preprocessImage(_image!);

    var output = List.generate(1, (_) => List.filled(2, 0));

    interpreter.run(input, output);

    setState(() {
      _output = output;
    });
  }

  TensorImage _preprocessImage(File image) {
    var rawBytes = image.readAsBytesSync();
    var decodedImage = img.decodeImage(rawBytes);
    var resizedImage = img.copyResize(decodedImage!, width: 224, height: 224);
    var inputImage = TensorImage.fromImage(resizedImage);

    return inputImage;
  }
}
