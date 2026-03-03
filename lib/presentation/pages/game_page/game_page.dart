import 'package:provider/provider.dart';
import 'package:second_touch/application/game_view_model.dart';
import 'package:second_touch/game/my_game.dart';
import 'package:second_touch/presentation/pages/game_page/widgets/direction_control.dart';

import 'widgets/game_control_bar.dart';
import 'widgets/pattern_menu_item.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
    return ChangeNotifierProvider(
      create: (_) => GameViewModel(widget.game),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Game Of Life'),
              
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
                    onResetView: () => widget.game.resetCameraView(),
                    onZoomIn: () => widget.game.zoomIn(),
                    onZoomOut: () => widget.game.zoomOut(),
                  ),
                ),
                // Positioned(
                //   top: 20,
                //   left: 20,
                //   child: GestureDetector(
                //     onTapDown: (_) =>
                //         widget.game.startMoving(Vector2(0, -1)),
                //     onTapUp: (_) =>
                //         widget.game.stopMoving(),
                //     onTapCancel: () =>
                //         widget.game.stopMoving(),
                //     child: const Icon(Icons.arrow_upward, size: 40),
                //   ),
                // ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.3,
                  right: 20,
                  child: DirectionControl(
                    onUp: () => widget.game.startMoving(Vector2(0, -1)),
                    onDown: () => widget.game.startMoving(Vector2(0, 1)),
                    onLeft: () => widget.game.startMoving(Vector2(-1, 0)),
                    onRight: () => widget.game.startMoving(Vector2(1, 0)),
                    onStop: () => widget.game.stopMoving(),
                  ),
                ),
                
              ],
            ),
          );
        }
      ),
    );
  }
}
