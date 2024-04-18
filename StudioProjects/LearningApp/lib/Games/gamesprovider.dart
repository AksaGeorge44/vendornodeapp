import 'package:flutter/material.dart';

class GamesProvider extends ChangeNotifier {
  List<String> games = [];

  void addGame(String gameTitle) {
    games.add(gameTitle);
    notifyListeners();
  }
}
