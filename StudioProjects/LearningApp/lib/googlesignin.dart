import 'package:flutter/material.dart';

class ChartApp extends StatefulWidget {
  const ChartApp({super.key});

  @override
  State<ChartApp> createState() => _ChartAppState();
}

class _ChartAppState extends State<ChartApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app"),
      ),
    );
  }
}
