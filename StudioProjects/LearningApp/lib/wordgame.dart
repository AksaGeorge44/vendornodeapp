import 'package:flutter/material.dart';
import 'package:learningapp/ImageDetection/homepageI.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),

      body: ListView(
        children: [
          buildgame(context, "game1", HomePage1())
        ],
      ),
    );
  }

  Widget buildgame(BuildContext context,String gamettitle,Widget gamepage)
  {
    return ListTile(
      title: Text(gamettitle),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage1()));
      },
    );
  }





}
