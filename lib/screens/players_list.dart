import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/models/player.dart';
import 'package:skrew_calculator/screens/players_scores.dart';
import 'package:skrew_calculator/widgets/new_player.dart';
import 'package:skrew_calculator/widgets/player_data.dart';
import 'package:skrew_calculator/providers/player_provider.dart';

class PlayersList extends ConsumerStatefulWidget {
  const PlayersList({super.key});

  @override
  ConsumerState<PlayersList> createState() {
    return _PlayersListState();
  }
}

class _PlayersListState extends ConsumerState<PlayersList> {
  late Future<void> players;

  @override
  void initState() {
    super.initState();
    // Schedule the loadPlayers to run after the widget has been built
    Future.microtask(() async {
      await ref.read(playerProvider.notifier).loadPlayers();
    });
  }

  void removePlayer(Player player) async {
    await ref.read(playerProvider.notifier).removePlayer(player);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Player removed'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            ref.read(playerProvider.notifier).addPlayer(player.name);
          },
        ),
      ),
    );
  }

  void _openAddPlayerDialog() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewPlayer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _players = ref.watch(playerProvider);

    Widget mainContent = const Center(
      child: Text('No players added yet!'),
    );

    if (_players.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _players.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Colors.red,
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
          key: ValueKey(_players[index].id), // Use player ID for key
          child: PlayerData(_players[index]),
          onDismissed: (dismissDirection) {
            removePlayer(_players[index]);
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
          if (_players.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(selectedPlayersProvider.notifier)
                          .setSelectedPlayers(_players
                              .where((player) => player.isSelected)
                              .toList());
                      ref.read(selectedPlayersProvider.notifier).clearScores();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return PlayersScoresScreen();
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
                    child: const Text('Start Game'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
