import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/providers/player_provider.dart';
import 'package:skrew_calculator/screens/final_results.dart';
import 'package:skrew_calculator/screens/player_scores.dart';

class PlayersScoresScreen extends ConsumerStatefulWidget {
  const PlayersScoresScreen({super.key});

  @override
  ConsumerState<PlayersScoresScreen> createState() =>
      _PlayersScoresScreenState();
}

class _PlayersScoresScreenState extends ConsumerState<PlayersScoresScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(selectedPlayersProvider.notifier).loadSelectedPlayers();
    });
  }

  void _clearScores() async {
    await ref.read(selectedPlayersProvider.notifier).clearScores();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Scores cleared!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _players = ref.watch(selectedPlayersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Players Scores'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _players.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(_players[index].name),
                          subtitle: Text('Score: ${_players[index].score}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) {
                                return PlayerScoresScreen(_players[index]);
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_players.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return FinalResultsScreen(); // Navigate to the final results screen
                        }),
                      );
                    },
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        const BorderSide(
                          color: Color.fromARGB(255, 34, 6, 53),
                        ),
                      ),
                    ),
                    child: const Text('Show Final Results'),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clearScores,
        child: const Icon(Icons.delete),
        tooltip: 'Clear Scores',
      ),
    );
  }
}
