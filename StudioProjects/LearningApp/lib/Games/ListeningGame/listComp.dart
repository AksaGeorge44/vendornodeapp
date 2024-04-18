import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class ListeningComprehensionGame extends StatefulWidget {
  @override
  _ListeningComprehensionGameState createState() =>
      _ListeningComprehensionGameState();
}

class _ListeningComprehensionGameState extends State<ListeningComprehensionGame> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playAudio('your_audio_file.mp3');
  }

  void playAudio(String audioPath) async {
    await audioPlayer.play(audioPath as Source);
    setState(() {
      isPlaying = true;
    });

    Future.delayed(Duration(seconds: 10), stopAudio);
  }

  void stopAudio() {
    audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Comprehension Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Listen to the audio and answer the question:'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: isPlaying ? null : () => playAudio('your_audio_file.mp3'),
            child: Text(isPlaying ? 'Playing...' : 'Play Audio'),
          ),
          SizedBox(height: 16),
          ListeningQuestion(),
        ],
      ),
    );
  }
}

class ListeningQuestion extends StatefulWidget {
  @override
  _ListeningQuestionState createState() => _ListeningQuestionState();
}

class _ListeningQuestionState extends State<ListeningQuestion> {
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Question: What did you hear?'),
        SizedBox(height: 8),
        TextField(
          controller: answerController,
          decoration: InputDecoration(
            hintText: 'Your Answer',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Replace 'correct_answer' with the expected answer
            String correctAnswer = 'correct_answer';
            String userAnswer = answerController.text.trim().toLowerCase();

            if (userAnswer == correctAnswer) {
              // Handle correct answer
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Correct Answer!'),
                  content: Text('Great job!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            } else {
              // Handle incorrect answer
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Incorrect Answer'),
                  content: Text('Try again!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text('Submit Answer'),
        ),
      ],
    );
  }
}
