import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/models/player.dart';
import 'package:skrew_calculator/providers/scores_provider.dart';
import 'package:skrew_calculator/widgets/add_score.dart';

class PlayerScoresScreen extends ConsumerStatefulWidget {
  final Player player;
  const PlayerScoresScreen(this.player, {Key? key}) : super(key: key);

  @override
  ConsumerState<PlayerScoresScreen> createState() => _PlayerScoresScreenState();
}

class _PlayerScoresScreenState extends ConsumerState<PlayerScoresScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the loadScores to run after the widget has been built
    Future.microtask(() {
      ref.read(scoresProvider.notifier).loadScores(widget.player);
    });
  }

  void _openAddScoreDialog() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return AddScore(widget.player);
      },
    );
  }

  void _openUpdateScoreDialog(int index) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return AddScore(widget.player, index: index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _scores = ref.watch(scoresProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.player.name} Scores'),
      ),
      body: ListView.builder(
        itemCount: _scores.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Score: ${_scores[index]}'),
                onTap: () => _openUpdateScoreDialog(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddScoreDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
