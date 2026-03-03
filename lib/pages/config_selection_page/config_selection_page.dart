import 'package:flutter/material.dart';
import 'package:second_touch/config/constants.dart';
import 'package:second_touch/my_game.dart';
import 'package:second_touch/pages/game_page/game_page.dart';

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

