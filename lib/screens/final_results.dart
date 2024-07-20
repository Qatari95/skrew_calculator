import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/providers/player_provider.dart';

class FinalResultsScreen extends ConsumerWidget {
  const FinalResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players = ref.watch(selectedPlayersProvider);

    // Sort players by their total score (ascending order)
    final sortedPlayers = players
        .map((player) => {
              'name': player.name,
              'scores': player.scores,
              'total': player.totalScore
            })
        .toList()
      ..sort((a, b) => a['total'].compareTo(b['total']));

    // Find the maximum number of scores
    final maxRounds = sortedPlayers
        .map((playerData) => (playerData['scores'] as List<int>).length)
        .reduce((a, b) => a > b ? a : b);

    // Create columns dynamically based on maxRounds
    final columns = List<DataColumn>.generate(
      maxRounds,
      (index) => DataColumn(label: Text('Round ${index + 1}')),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
              (states) => Colors.deepPurple.shade100,
            ),
            columns: [
              DataColumn(label: Text('Player')),
              ...columns, // Add dynamic columns for each round
              DataColumn(label: Text('Total')), // Add a column for Total
            ],
            rows: sortedPlayers.map((playerData) {
              final scores = playerData['scores'] as List<int>;
              final scoresStrList = List.generate(
                maxRounds,
                (index) =>
                    index < scores.length ? scores[index].toString() : '0',
              );

              return DataRow(cells: [
                DataCell(Text(playerData['name'])),
                ...scoresStrList.map((score) => DataCell(Text(score))),
                DataCell(Text(playerData['total'].toString())),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
