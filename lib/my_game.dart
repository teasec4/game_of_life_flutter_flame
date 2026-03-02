import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'config/constants.dart';
import 'game/game_world.dart';

class MyGame extends FlameGame {
  MyGame()
      : super(
          world: GameWorld(),
          camera: CameraComponent(
            viewport: FixedAspectRatioViewport(
              aspectRatio: gameWidth / gameHeight, // Портретное соотношение 9:16
            ),
          ),
        );

  @override
  Color backgroundColor() => Colors.grey;
}
