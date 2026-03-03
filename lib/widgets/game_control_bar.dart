import 'package:flutter/material.dart';

class GameControlBar extends StatefulWidget {
  final VoidCallback onResetGame;
  final VoidCallback onStartGame;
  final Function(double) onSpeedChanged;
  final double initialSpeed;
  final String? selectedPattern;
  final VoidCallback onPatternCanceled;

  const GameControlBar({
    super.key,
    required this.onResetGame,
    required this.onStartGame,
    required this.onSpeedChanged,
    this.initialSpeed = 0.3,
    this.selectedPattern,
    required this.onPatternCanceled,
  });

  @override
  State<GameControlBar> createState() => _GameControlBarState();
}

class _GameControlBarState extends State<GameControlBar>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late double _currentSpeed;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _currentSpeed = widget.initialSpeed;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
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
        // Pattern notification bar
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
        // Control bar
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with toggle button
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: widget.onResetGame,
                            icon: const Icon(Icons.restart_alt),
                            label: const Text('Reset'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: widget.onStartGame,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start'),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: AnimatedRotation(
                        turns: _isExpanded ? 0 : 0.5,
                        duration: const Duration(milliseconds: 300),
                        child: const Icon(
                          Icons.expand_more,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _toggleExpanded,
                      tooltip: _isExpanded ? 'Collapse' : 'Expand',
                    ),
                  ],
                ),
              ),
              // Expandable content
              SizeTransition(
                sizeFactor: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Speed: ${_currentSpeed.toStringAsFixed(2)}s',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Slow',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: _currentSpeed,
                                min: 0.05,
                                max: 1.0,
                                divisions: 19,
                                onChanged: _updateSpeed,
                              ),
                            ),
                            const Text(
                              'Fast',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
