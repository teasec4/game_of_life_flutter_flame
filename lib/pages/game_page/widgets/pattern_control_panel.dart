import 'package:flutter/material.dart';

class PatternControlPanel extends StatefulWidget {
  final VoidCallback onResetGame;
  final VoidCallback onStartGame;
  final Function(String) onPatternSelected;
  final VoidCallback onPatternCanceled;
  final Function(double) onSpeedChanged;
  final double initialSpeed;
  final String? selectedPattern;

  const PatternControlPanel({
    super.key,
    required this.onResetGame,
    required this.onStartGame,
    required this.onPatternSelected,
    required this.onPatternCanceled,
    required this.onSpeedChanged,
    this.initialSpeed = 0.3,
    this.selectedPattern,
  });

  @override
  State<PatternControlPanel> createState() => _PatternControlPanelState();
}

class _PatternControlPanelState extends State<PatternControlPanel> {
  late double _currentSpeed;

  @override
  void initState() {
    super.initState();
    _currentSpeed = widget.initialSpeed;
  }

  void _resetGame() {
    widget.onResetGame();
  }

  void _updateSpeed(double value) {
    setState(() {
      _currentSpeed = value;
    });
    widget.onSpeedChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.selectedPattern != null)
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Выбери место для ${widget.selectedPattern}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
                TextButton(
                  onPressed: widget.onPatternCanceled,
                  child: const Text('Отмена'),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reset'),
            ),
            ElevatedButton(
              onPressed: widget.onStartGame,
              child: const Text('Start'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                'Speed: ${_currentSpeed.toStringAsFixed(2)}s',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text('Slow', style: TextStyle(fontSize: 10)),
                  Expanded(
                    child: Slider(
                      value: _currentSpeed,
                      min: 0.05,
                      max: 1.0,
                      divisions: 19,
                      onChanged: _updateSpeed,
                    ),
                  ),
                  const Text('Fast', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
