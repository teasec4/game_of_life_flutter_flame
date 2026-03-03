import 'package:flame/game.dart';
import 'package:flame/camera.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'config/constants.dart';
import 'components/grid.dart';

class MyGame extends FlameGame {
  late Grid grid;
  late GridConfig currentConfig;
  double updateInterval = 0.3; // Скорость обновления в секундах

  MyGame({GridConfig? config})
      : currentConfig = config ?? gridConfigs[2],
        super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    grid = Grid(
      cellSize: currentConfig.cellSize,
      cols: currentConfig.cols,
      rows: currentConfig.rows,
      updateInterval: updateInterval,
    );
    add(grid);
    
    camera = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    );
    
    // Устанавливаем viewfinder на (0, 0)
    camera.viewfinder.position = Vector2.zero();
    camera.viewfinder.anchor = Anchor.topLeft;
    
    addAll([camera]);
  }

  void recreateGridWithConfig(GridConfig config) {
    currentConfig = config;
    remove(grid);
    grid = Grid(
      cellSize: currentConfig.cellSize,
      cols: currentConfig.cols,
      rows: currentConfig.rows,
      updateInterval: updateInterval,
    );
    add(grid);
  }

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

  @override
  Color backgroundColor() => Colors.grey;
}
