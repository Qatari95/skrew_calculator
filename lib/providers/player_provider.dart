import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/models/player.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

Future<sql.Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  return await sql.openDatabase(path.join(dbPath, 'skrew.db'),
      onCreate: (db, version) {
    return db.execute('CREATE TABLE players(id TEXT PRIMARY KEY,name TEXT)');
  }, version: 1);
}

class PlayerProvider extends StateNotifier<List<Player>> {
  PlayerProvider() : super([]);

  Future<void> addPlayer(String name) async {
    final db = await _getDatabase();
    final newPlayer = Player(name: name);
    await db.insert('players', {'id': newPlayer.id, 'name': newPlayer.name});
    state = [...state, newPlayer];
  }

  Future<void> loadPlayers() async {
    final db = await _getDatabase();
    final playersData = await db.query('players');
    final loadedPlayers = playersData
        .map((item) =>
            Player(name: item['name'].toString(), id: item['id'].toString()))
        .toList();
    state = loadedPlayers;
  }

  Future<void> removePlayer(Player player) async {
    final db = await _getDatabase();
    await db.delete('players', where: 'id = ?', whereArgs: [player.id]);
    state = state.where((element) => element.id != player.id).toList();
  }
}

// Separate provider for selected players
class SelectedPlayersProvider extends StateNotifier<List<Player>> {
  SelectedPlayersProvider() : super([]);

  void setSelectedPlayers(List<Player> players) {
    state = players;
  }

  void loadSelectedPlayers() {
    final selectedPlayers =
        state.map((item) => item).where((player) => player.isSelected).toList();
    state = selectedPlayers;
  }

  Future<void> addScore(Player player, int score) async {
    player.score += score;
    state = [...state];
  }

  Future<void> updateScore(Player player, int index, int score) async {
    if (index >= player.scores.length) return;
    player.score -= player.scores[index];
    player.scores[index] = score;
    player.score += score;
    state = [...state];
  }

  Future<void> clearScores() async {
    state.forEach((player) {
      player.score = 0;
      player.scores.clear();
    });
    state = [...state];
  }
}

final playerProvider = StateNotifierProvider<PlayerProvider, List<Player>>(
  (ref) => PlayerProvider(),
);

final selectedPlayersProvider =
    StateNotifierProvider<SelectedPlayersProvider, List<Player>>(
  (ref) => SelectedPlayersProvider(),
);
