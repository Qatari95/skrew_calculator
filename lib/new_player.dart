import 'package:flutter/material.dart';

class NewPlayer extends StatefulWidget {
  final void Function(String) addPlayer;
  const NewPlayer(this.addPlayer, {super.key});

  @override
  State<NewPlayer> createState() {
    return _NewPlayerState();
  }
}

class _NewPlayerState extends State<NewPlayer> {
  final _controller = TextEditingController();
  _submitData() {
    final enteredName = _controller.text;
    if (enteredName.isEmpty) {
      return;
    }
    widget.addPlayer(enteredName);
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
