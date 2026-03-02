import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'my_game.dart';

void main() {
  final game = MyGame();
  runApp(
    GameWidget(
      game: game,
      // overlayBuilderMap: ,
    ),
  );
}
