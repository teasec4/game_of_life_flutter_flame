import 'package:flame/game.dart';
import 'package:flame/camera.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'config/constants.dart';
import 'game/game_world.dart';

class MyGame extends FlameGame {
  late GameWorld gameWorld;
  final GridConfig? config;

  MyGame({this.config}) : super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gameWorld = GameWorld(config: config);
    world = gameWorld;
    
    camera = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
      world: world,
    );
    
    // Устанавливаем viewfinder на (0, 0)
    camera.viewfinder.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;
    
    addAll([world, camera]);
  }

  @override
  Color backgroundColor() => Colors.grey;
}
