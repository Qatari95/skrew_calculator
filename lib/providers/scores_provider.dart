import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/models/player.dart';

class ScoresProvider extends StateNotifier<List<int>> {
  ScoresProvider() : super([]);
  void loadScores(Player player) {
    if (player.scores.isNotEmpty) {
      state = player.scores;
      return;
    }
    state = [];
  }

  void addScore(Player player, int score) {
    player.scores.add(score);
    state = List.from(player.scores); // Ensure state is updated with a new list
  }

  void updateScore(Player player, int index, int score) {
    if (index >= player.scores.length) return;
    player.scores[index] = score;
    state = List.from(player.scores); // Ensure state is updated with a new list
  }
}

final scoresProvider = StateNotifierProvider<ScoresProvider, List<int>>(
  (ref) => ScoresProvider(),
);
