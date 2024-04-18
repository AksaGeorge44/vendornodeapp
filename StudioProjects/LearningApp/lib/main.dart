import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/Auth/login.dart';
import 'package:learningapp/Games/alphabetboardGame.dart';
import 'package:learningapp/Games/sample1.dart';
import 'package:learningapp/Home/homepage.dart';
import 'package:learningapp/firebase_options.dart';
import 'package:learningapp/googlesignin.dart';


List<CameraDescription> cameras = [];

Future<void> main() async{
WidgetsFlutterBinding.ensureInitialized();
cameras = await availableCameras();

await Firebase.initializeApp(
 options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learn App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:ChartApp()
      ),
    );
  }
}

