import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;

  const DetailScreen({required this.imagePath});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final String _imagePath;
  Size? _imageSize;
  List<String> birdData = [];
  List<String> confidenceData = [];

  // Placeholder method for bird species recognition
  Future<void> _recognizeBird(String imagePath) async {
    setState(() {
      birdData = ['Placeholder Bird Breed'];
      confidenceData = ['0.75']; // Placeholder confidence score
    });
  }

  @override
  void initState() {
    _imagePath = widget.imagePath;

    _getImageSize(File(_imagePath)).then((_) {
      _recognizeBird(_imagePath); // Call the bird recognition method
    });

    super.initState();
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bird Details"),
      ),
      body: _imageSize != null
          ? Stack(
        children: [
          Container(
            width: double.maxFinite,
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: _imageSize!.aspectRatio,
              child: Image.file(
                File(_imagePath),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: 8,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Bird Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: birdData.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Breed: ${birdData[index]}"),
                                Text("Confidence: ${confidenceData[index]}"),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
          : Container(
        color: Colors.blue,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
