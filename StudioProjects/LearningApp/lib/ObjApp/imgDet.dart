import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class ImageML extends StatefulWidget {
  const ImageML({Key? key}) : super(key: key);

  @override
  _ImageMLState createState() => _ImageMLState();
}

class _ImageMLState extends State<ImageML> {
  late CameraImage cameraImage;
  CameraController? cameraController;
  late Interpreter interpreter;
  late File _selectedImage;
  late bool _isImageLoaded;
  String _result = '';
  late Float32List inputTensor;

  final int inputSize = 224;

  @override
  void initState() {
    super.initState();
    _isImageLoaded = false;
    inputTensor = Float32List(inputSize * inputSize);
    loadModel();
    initCamera();
  }

  @override
  void dispose() async {
    super.dispose();
    interpreter.close();
    await cameraController?.dispose();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/model.tflite');
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController?.initialize();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      await _validateAndProcessImage(_selectedImage);
      setState(() {
        _isImageLoaded = true; // Set flag to indicate image loaded
      });
    }
  }

  Future<void> _validateAndProcessImage(File imageFile) async {
    // Read image bytes
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Decode image
    img.Image? image = img.decodeImage(imageBytes);
    if (image == null) {
      print('Failed to decode image.');
      return;
    }

    // Check intensity range of pixel values
    bool validRange = _checkPixelValueRange(image, 0, 255);
    if (!validRange) {
      print('Pixel values are not within expected range.');
      return;
    }

    // Resize image to match input size
    img.Image resizedImage = img.copyResize(image, width: inputSize, height: inputSize);

    // Convert to input tensor format
    inputTensor = _imageToTensor(resizedImage);
  }

  // Check pixel value range
  bool _checkPixelValueRange(img.Image image, int min, int max) {
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        int pixelValue = image.getPixel(x, y);
        if (pixelValue < min || pixelValue > max) {
          return false;
        }
      }
    }
    return true;
  }

  Float32List _imageToTensor(img.Image image) {
    final grayscaleImage = img.grayscale(image);
    final resizedImage = img.copyResize(grayscaleImage, width: inputSize, height: inputSize);

    double mean = 0.0;
    double std = 0.0;
    int pixelCount = 0;

    // Calculate mean
    for (int i = 0; i < inputSize; i++) {
      for (int j = 0; j < inputSize; j++) {
        mean += resizedImage.getPixel(j, i);
        pixelCount++;
      }
    }
    mean /= pixelCount;

    // Calculate standard deviation
    for (int i = 0; i < inputSize; i++) {
      for (int j = 0; j < inputSize; j++) {
        std += pow((resizedImage.getPixel(j, i) - mean), 2);
      }
    }
    std = sqrt(std / pixelCount);

    final List<double> inputData = List<double>.filled(inputSize * inputSize, 0.0);
    for (int i = 0; i < inputSize; i++) {
      for (int j = 0; j < inputSize; j++) {
        final pixel = resizedImage.getPixel(j, i);
        inputData[i * inputSize + j] = (pixel - mean) / std; // Normalize based on image mean and std
      }
    }

    return Float32List.fromList(inputData);
  }


  Future<void> _runModel() async {
    // Check if image is loaded before running the model
    if (!_isImageLoaded) {
      setState(() {
        _result = 'Image is not loaded. Please select an image or wait for image processing to finish.';
      });
      return;
    }

    try {
      var input = [[1.23, 6.54, 7.81, 3.21, 2.22]];

      var output = List.filled(1*2, 0).reshape([1,2]);
      interpreter.run(input, output);
      print(output);

      var tumorProbability = output[0];
      var tumorThreshold = 0.5;
      var prediction = tumorProbability >= tumorThreshold ? 'Tumor' : 'Not Tumor';

      setState(() {
        _result = 'Prediction: $prediction';
      });
    } catch (e) {
      setState(() {
        _result = 'Error running model: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brain Tumor Detection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (cameraController != null && cameraController!.value.isInitialized)
              AspectRatio(
                aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Select Image from Gallery'),
            ),
            const SizedBox(height: 20),
            if (_isImageLoaded)
              Column(
                children: [
                  Image.file(_selectedImage),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _runModel,
                    child: const Text('Run Model'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _result,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            if (!_isImageLoaded) // Show placeholder only when image is not loaded
              Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

