import 'package:flutter/material.dart';
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

  // _openAddScoreDialog() {
  //   showModalBottomSheet(
  //       useSafeArea: true,
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (ctx) {
  //         return AddScore(addScore);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Checkbox(
          value: widget.player.isSelected,
          onChanged: (value) {
            setState(() {
              widget.player.isSelected = value!;
            });
          },
        ),
        title: Text(widget.player.name),
      ),
    );
  }
}
