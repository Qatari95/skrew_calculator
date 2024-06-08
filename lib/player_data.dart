import 'package:flutter/material.dart';
import 'package:skrew_calculator/add_score.dart';
import 'package:skrew_calculator/models/player.dart';

class PlayerData extends StatefulWidget {
  final Player player;
  const PlayerData(this.player, {super.key});

  @override
  State<PlayerData> createState() {
    return _PlayerDataState();
  }
}

class _PlayerDataState extends State<PlayerData> {
  addScore(int score) {
    setState(() {
      widget.player.scores.add(score);
    });
  }

  _openAddScoreDialog() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return AddScore(addScore);
        });
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          child: Text(widget.player.name[0]),
        ),
        title: Text(widget.player.name),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Column(
                children: [
                  Column(
                    children: widget.player.scores
                        .map(
                          (round) => Text('Round ${++index} Score - $round'),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  Text('Total: ${widget.player.totalScore}'),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _openAddScoreDialog,
                  child: const Text('Add Score'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
