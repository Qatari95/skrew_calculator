import 'package:flutter/material.dart';

class AddScore extends StatefulWidget {
  final Function(int) addScore;

  const AddScore(this.addScore, {super.key});

  @override
  State<AddScore> createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  final _scoreController = TextEditingController();

  void _submitData() {
    final enteredScore = int.parse(_scoreController.text);
    if (enteredScore <= 0) {
      return;
    }

    widget.addScore(enteredScore);
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
