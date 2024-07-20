import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/models/player.dart';
import 'package:skrew_calculator/providers/player_provider.dart';
import 'package:skrew_calculator/providers/scores_provider.dart';

class AddScore extends ConsumerStatefulWidget {
  final Player player;
  final int? index;
  const AddScore(this.player, {super.key, this.index});

  @override
  ConsumerState<AddScore> createState() => _AddScoreState();
}

class _AddScoreState extends ConsumerState<AddScore> {
  final _scoreController = TextEditingController();

  void _submitData() {
    final enteredScore = int.parse(_scoreController.text);
    if (enteredScore < 0) {
      return;
    }
    if (widget.index != null) {
      ref
          .read(selectedPlayersProvider.notifier)
          .updateScore(widget.player, widget.index!, enteredScore);
      ref
          .read(scoresProvider.notifier)
          .updateScore(widget.player, widget.index!, enteredScore);
      Navigator.of(context).pop();
      return;
    }
    ref.read(scoresProvider.notifier).addScore(widget.player, enteredScore);
    ref
        .read(selectedPlayersProvider.notifier)
        .addScore(widget.player, enteredScore);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _scoreController,
          decoration: const InputDecoration(
            labelText: 'Enter score',
          ),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: _submitData,
          child: const Text('Add Score'),
        ),
      ],
    );
  }
}
