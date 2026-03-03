import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';
import 'config/constants.dart';
import 'widgets/game_control_bar.dart';
import 'widgets/pattern_menu_item.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ConfigSelectionPage(),
    ),
  );
}

class ConfigSelectionPage extends StatelessWidget {
  const ConfigSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game of Life - Select Grid Size')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // gridConfigs form constant
          children: gridConfigs.map((config) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {
                  final game = MyGame(config: config);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => GamePage(game: game),
                    ),
                  );
                },
                child: Text('${config.name} (${config.cols}x${config.rows} cells)'),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final MyGame game;

  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String? _selectedPatternDisplay;

  void _selectPatternFromMenu(String pattern) {
    widget.game.setPatternToPlace(pattern);
    setState(() {
      _selectedPatternDisplay = pattern == 'block'
          ? 'Block'
          : pattern == 'blinker'
              ? 'Blinker'
              : 'Glider';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Select location for $_selectedPatternDisplay'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _cancelPattern() {
    widget.game.cancelPatternPlacement();
    setState(() {
      _selectedPatternDisplay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Of Life'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ConfigSelectionPage(),
              ),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _selectPatternFromMenu,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'block',
                child: PatternMenuItem(
                  name: 'Block',
                  pattern: patternVisualizations['block']!,
                ),
              ),
              PopupMenuItem<String>(
                value: 'blinker',
                child: PatternMenuItem(
                  name: 'Blinker',
                  pattern: patternVisualizations['blinker']!,
                ),
              ),
              PopupMenuItem<String>(
                value: 'glider',
                child: PatternMenuItem(
                  name: 'Glider',
                  pattern: patternVisualizations['glider']!,
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'toad',
                child: PatternMenuItem(
                  name: 'Toad',
                  pattern: patternVisualizations['toad']!,
                ),
              ),
              PopupMenuItem<String>(
                value: 'beacon',
                child: PatternMenuItem(
                  name: 'Beacon',
                  pattern: patternVisualizations['beacon']!,
                ),
              ),
              PopupMenuItem<String>(
                value: 'beehive',
                child: PatternMenuItem(
                  name: 'Beehive',
                  pattern: patternVisualizations['beehive']!,
                ),
              ),
              PopupMenuItem<String>(
                value: 'pentomino',
                child: PatternMenuItem(
                  name: 'R-Pentomino',
                  pattern: patternVisualizations['pentomino']!,
                ),
              ),
            ],
            tooltip: 'Add Pattern',
          ),
        ],
      ),
      body: Stack(
        children: [
          GameWidget(game: widget.game),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GameControlBar(
              onResetGame: () {
                widget.game.resetGame();
                setState(() {
                  _selectedPatternDisplay = null;
                });
              },
              onStartGame: () => widget.game.startGame(),
              onSpeedChanged: (speed) => widget.game.setUpdateInterval(speed),
              initialSpeed: widget.game.updateInterval,
              selectedPattern: _selectedPatternDisplay,
              onPatternCanceled: _cancelPattern,
            ),
          ),
        ],
      ),
    );
  }
}
