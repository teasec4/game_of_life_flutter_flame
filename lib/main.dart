import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';
import 'config/constants.dart';

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
  String? selectedPattern;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Of Life'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ConfigSelectionPage(),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          GameWidget(game: widget.game),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedPattern != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Выбери место для $selectedPattern',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.game.gameWorld.cancelPatternPlacement();
                            setState(() {
                              selectedPattern = null;
                            });
                          },
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedPattern == 'Block'
                            ? Colors.blue
                            : Colors.blueAccent,
                      ),
                      onPressed: selectedPattern == null
                          ? () {
                              widget.game.gameWorld
                                  .setPatternToPlace('block');
                              setState(() {
                                selectedPattern = 'Block';
                              });
                            }
                          : null,
                      child: const Text('Block'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedPattern == 'Blinker'
                            ? Colors.blue
                            : Colors.blueAccent,
                      ),
                      onPressed: selectedPattern == null
                          ? () {
                              widget.game.gameWorld
                                  .setPatternToPlace('blinker');
                              setState(() {
                                selectedPattern = 'Blinker';
                              });
                            }
                          : null,
                      child: const Text('Blinker'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedPattern == 'Glider'
                            ? Colors.blue
                            : Colors.blueAccent,
                      ),
                      onPressed: selectedPattern == null
                          ? () {
                              widget.game.gameWorld
                                  .setPatternToPlace('glider');
                              setState(() {
                                selectedPattern = 'Glider';
                              });
                            }
                          : null,
                      child: const Text('Glider'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.game.gameWorld.resetGame();
                        setState(() {
                          selectedPattern = null;
                        });
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.game.gameWorld.startGame();
                        setState(() {});
                      },
                      child: const Text('Start'),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
