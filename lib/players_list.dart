import 'package:flutter/material.dart';
import 'package:skrew_calculator/models/player.dart';
import 'package:skrew_calculator/new_player.dart';
import 'package:skrew_calculator/player_data.dart';

class PlayersList extends StatefulWidget {
  const PlayersList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayersListState();
  }
}

class _PlayersListState extends State<PlayersList> {
  final players = <Player>[];

  addPlayer(String name) {
    setState(() {
      players.add(Player(name: name));
    });
  }

  void removePlayer(Player player) {
    final expenseIndex = players.indexOf(player);
    setState(() {
      players.remove(player);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              players.insert(expenseIndex, player);
            });
          },
        ),
      ),
    );
  }

  _openAddPlayerDialog() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewPlayer(addPlayer);
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No players added yet!'),
    );
    if (players.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: players.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
          ),
          key: ValueKey(players[index]),
          child: PlayerData(players[index]),
          onDismissed: (dismissDirection) {
            if (dismissDirection == DismissDirection.endToStart) {
              removePlayer(players[index]);
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 160, 6, 190),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddPlayerDialog,
          ),
        ],
        title: const Text('Players List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: mainContent,
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                players.clear();
              });
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Color.fromARGB(255, 34, 6, 53),
                ),
              ),
            ),
            child: const Text('Clear All Players'),
          ),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () {
              setState(() {
                for (var player in players) {
                  player.scores.clear();
                }
              });
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Color.fromARGB(255, 34, 6, 53),
                ),
              ),
            ),
            child: const Text('Reset Scores'),
          ),
        ],
      ),
    );
  }
}
