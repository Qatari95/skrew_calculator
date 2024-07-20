import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Player {
  final String name;
  final String id;
  var isSelected = false;
  var score = 0;
  final scores = List<int>.empty(growable: true);
  get totalScore {
    if (scores.isEmpty) {
      return 0;
    }
    return scores.reduce((value, element) => value + element);
  }

  Player({required this.name, id}) : id = id ?? uuid.v4();
}
