// import 'package:carousel_slider/carousel_options.dart';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
//
// class VocabularyScreen extends StatefulWidget {
//   const VocabularyScreen({super.key});
//
//   @override
//   _VocabularyScreenState createState() => _VocabularyScreenState();
// }
//
// class _VocabularyScreenState extends State<VocabularyScreen> {
//   List<VocabularyCard> vocabularyList = [
//     VocabularyCard(word: 'Cat', image: 'cat.jpg', audio: 'cat.mp3'),
//     VocabularyCard(word: 'Dog', image: 'dog.jpg', audio: 'dog.mp3'),
//     // Add more vocabulary cards as needed
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Basic English Vocabulary'),
//       ),
//       body: CarouselSlider.builder(
//         itemCount: vocabularyList.length,
//         itemBuilder: (BuildContext context, int index, int realIndex) {
//           return VocabularyCardWidget(vocabularyCard: vocabularyList[index]);
//         },
//         options: CarouselOptions(
//           height: MediaQuery.of(context).size.height,
//           viewportFraction: 1.0,
//           enlargeCenterPage: false,
//           autoPlay: false,
//         ),
//       ),
//     );
//   }
// }
//
// class VocabularyCard {
//   final String word;
//   final String image;
//   final String audio;
//
//   VocabularyCard({required this.word, required this.image, required this.audio});
// }
//
// class VocabularyCardWidget extends StatelessWidget {
//   final VocabularyCard vocabularyCard;
//   final AudioPlayer audioPlayer = AudioPlayer();
//
//   VocabularyCardWidget({super.key, required this.vocabularyCard});
//
//   void playAudio() async {
//     int result = await audioPlayer.play(vocabularyCard.audio, isLocal: false);
//
//     if (result == 1) {
//       // success
//     } else {
//       // error
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/images/${vocabularyCard.image}',
//             height: 200,
//             width: 200,
//           ),
//           SizedBox(height: 20),
//           Text(
//             vocabularyCard.word,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               playAudio();
//             },
//             child: Text('Play Audio'),
//           ),
//         ],
//       ),
//     );
//   }
// }
