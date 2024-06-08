class Player {
  final String name;
  final scores = List<int>.empty(growable: true);
  get totalScore {
    if (scores.isEmpty) {
      return 0;
    }
    return scores.reduce((value, element) => value + element);
  }

  Player({required this.name});
}
