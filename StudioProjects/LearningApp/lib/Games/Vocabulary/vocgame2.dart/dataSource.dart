import 'model.dart';

class VocabularyDataSource {
  List<VocabularyItem> getAnimals() {
    return [
      VocabularyItem(
        name: 'Lion',
        imagePath: 'assets/animals/lion.jpg',
        audioPath: 'assets/animals/lion.mp3',
      ),
    ];
  }

}
