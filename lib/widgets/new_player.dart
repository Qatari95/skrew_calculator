import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skrew_calculator/providers/player_provider.dart';

class NewPlayer extends ConsumerStatefulWidget {
  const NewPlayer({super.key});

  @override
  ConsumerState<NewPlayer> createState() {
    return _NewPlayerState();
  }
}

class _NewPlayerState extends ConsumerState<NewPlayer> {
  final _controller = TextEditingController();
  _submitData() {
    final enteredName = _controller.text;
    if (enteredName.isEmpty) {
      return;
    }
    ref.read(playerProvider.notifier).addPlayer(enteredName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Enter player name',
          ),
        ),
        ElevatedButton(
          onPressed: _submitData,
          child: const Text('Add Player'),
        ),
      ],
    );
  }
}
