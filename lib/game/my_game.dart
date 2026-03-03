import 'package:flame/game.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:second_touch/game/grid/grid_size.dart';
import '../components/grid.dart';

class MyGame extends FlameGame {
  late Grid grid;
  final GridSizeConfig currentConfig;
  double updateInterval = 0.3; // Скорость обновления в секундах

  // Параметры zoom и pan
  static const double minZoom = 0.2;
  static const double maxZoom = 10.0;
  late World gameWorld;
  late CameraComponent gameCamera;
  Vector2 cameraVelocity = Vector2.zero();

  MyGame({required this.currentConfig});

  @override
  Future<void> onLoad() async {
    super.onLoad();

    grid = Grid(
      cellSize: currentConfig.cellSize,
      cols: currentConfig.cols,
      rows: currentConfig.rows,
      updateInterval: updateInterval,
    );

    // Создаём World для камеры
    gameWorld = World();
    gameWorld.add(grid);

    gameCamera = CameraComponent(world: gameWorld)
      ..viewfinder.position = Vector2.zero()
      ..viewfinder.anchor = Anchor.topLeft;

    addAll([gameWorld, gameCamera]);
  }

  // void recreateGridWithConfig(GridSizeConfig config) {
  //   currentConfig = config;
  //   remove(grid);
  //   grid = Grid(
  //     cellSize: currentConfig.cellSize,
  //     cols: currentConfig.cols,
  //     rows: currentConfig.rows,
  //     updateInterval: updateInterval,
  //   );
  //   add(grid);
  // }

  void setUpdateInterval(double interval) {
    updateInterval = interval;
    grid.updateInterval = interval;
  }

  void resetGame() => grid.reset();
  void startGame() => grid.start();
  void addGlider(int col, int row) => grid.addGlider(col, row);
  void addBlinker(int col, int row) => grid.addBlinker(col, row);
  void addBlock(int col, int row) => grid.addBlock(col, row);
  void addToad(int col, int row) => grid.addToad(col, row);
  void addBeacon(int col, int row) => grid.addBeacon(col, row);
  void addBeehive(int col, int row) => grid.addBeehive(col, row);
  void addPentomino(int col, int row) => grid.addPentomino(col, row);
  void setPatternToPlace(String pattern) => grid.setPatternToPlace(pattern);
  void cancelPatternPlacement() => grid.cancelPatternPlacement();

  /// Увеличить масштаб
  void zoomIn() {
    final newZoom = (camera.viewfinder.zoom * 1.2)
        .clamp(minZoom, maxZoom)
        .toDouble();
    gameCamera.viewfinder.zoom = newZoom;
  }

  /// Уменьшить масштаб
  void zoomOut() {
    final newZoom = (camera.viewfinder.zoom * 0.8)
        .clamp(minZoom, maxZoom)
        .toDouble();
    gameCamera.viewfinder.zoom = newZoom;
  }

  /// Центрирование камеры на сетку
  void resetCameraView() {
    gameCamera.viewfinder.zoom = 1.0;
    gameCamera.viewfinder.position = Vector2.zero();
  }
  
  void startMoving(Vector2 direction) {
    cameraVelocity = direction;
  }
  
  void stopMoving() {
    cameraVelocity = Vector2.zero();
  }
  
  // context.read<GameViewModel>().startMoving();

  @override
  Color backgroundColor() => Colors.grey;
  
  @override
  void update(double dt) {
  super.update(dt);
  
    if (cameraVelocity != Vector2.zero()) {
      gameCamera.viewfinder.position += 
      cameraVelocity * 300 * dt; // 300 = скорость
    }
  }
}
