import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

import '../main.dart';

class HomePageML extends StatefulWidget {
  const HomePageML({Key? key}) : super(key: key);

  @override
  State<HomePageML> createState() => _HomePageMLState();
}

class _HomePageMLState extends State<HomePageML> {
  late CameraImage imgCamera;
  late CameraController cameraController;
  bool isWorking = false;
  String result = '';

  late Interpreter interpreter;
  late List<int> interpreterOutputTensors;

  loadModel() async {
    interpreter = await Interpreter.fromAsset(
      'assets/mobilenet_v1_1.0_224.tflite',
      options: InterpreterOptions()..threads = 4,
    );

    interpreterOutputTensors = [0]; // If the output tensor index is 0
    // interpreterOutputTensors = interpreter.getOutputTensors(); // If you want to get all output tensors
  }

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imgCamera = imageFromStream;
            runModelOnStreamFrames();
          }
        });
      });
    });
  }

  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var bytes = imgCamera.planes.map((plane) {
        return plane.bytes;
      }).toList();

      var input = TensorImage.fromFile(imgCamera as File);
      interpreter.runForMultipleInputs([input], {0: interpreterOutputTensors});


    }
  }


  @override
  void initState() {
    super.initState();
    loadModel();
    initCamera();
  }

  @override
  void dispose() async {
    super.dispose();
     interpreter.close();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 320,
                    width: 330,
                    color: Colors.blue,
                    child: Image.asset('assets/images/images.jpg'),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: imgCamera == null
                        ? Container(
                      height: 270,
                      width: 360,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.blueAccent,
                        size: 40,
                      ),
                    )
                        : AspectRatio(
                      aspectRatio: cameraController.value.aspectRatio,
                      child: CameraPreview(cameraController),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 55),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: TextStyle(
                      backgroundColor: Colors.black87,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
