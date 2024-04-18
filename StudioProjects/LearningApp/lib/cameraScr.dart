import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'detailScr.dart';
import '../main.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraController _controller;

  // Initializes camera controller to preview on screen
  void _initializeCamera() async {
    final CameraController cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    _controller = cameraController;

    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  Future<String?> _takePicture() async {
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    if (_controller.value.isTakingPicture) {
      print("Processing is progress ...");
      return null;
    }

    try {
      // Turning off the camera flash
      _controller.setFlashMode(FlashMode.off);

      // Returns the image in cross-platform file abstraction
      final XFile file = await _controller.takePicture();

      // Retrieving the path
      if (file != null) {
        String imagePath = file.path;
        return imagePath;
      } else {
        print('Image path not found!');
        return null;
      }
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            imagePath: pickedFile.path,
          ),
        ),
      ).then((_) {
        setState(() {}); // Trigger rebuild after returning from DetailScreen
      });
    }
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    // dispose the camera controller when navigated
    // to a different page
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GeeksForGeeks'),
        actions: [
          IconButton(
            onPressed: () {
              _uploadImage();
            },
            icon: Icon(Icons.upload),
          ),
          IconButton(
            onPressed: () async {
              String? path = await _takePicture();
              if (path != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      imagePath: path,
                    ),
                  ),
                );
              } else {
                print('Image path not found!');
              }
            },
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: _controller.value.isInitialized
          ? Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Click"),
                onPressed: () async {
                  String? path = await _takePicture();
                  if (path != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          imagePath: path,
                        ),
                      ),
                    );
                  } else {
                    print('Image path not found!');
                  }
                },
              ),
            ),
          )
        ],
      )
          : Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.upload),
          label: Text("Upload Image"),
          onPressed: _uploadImage,
        ),
      ),
    );
  }
}
