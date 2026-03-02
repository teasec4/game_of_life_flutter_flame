import 'package:flame/components.dart';
import '../components/grid.dart';
import '../config/constants.dart';

class GameWorld extends World {
  late Grid grid;
  late GridConfig currentConfig;

  GameWorld({GridConfig? config}) {
    currentConfig = config ?? gridConfigs[1]; // Medium по умолчанию
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Инициализируем сетку Game of Life
    grid = Grid(
      cellSize: currentConfig.cellSize,
      cols: currentConfig.cols,
      rows: currentConfig.rows,
    );
    add(grid);
  }

  void recreateGridWithConfig(GridConfig config) {
    currentConfig = config;
    remove(grid);
    grid = Grid(
      cellSize: currentConfig.cellSize,
      cols: currentConfig.cols,
      rows: currentConfig.rows,
    );
    add(grid);
  }

  void resetGame() {
    grid.reset();
  }

  void startGame() {
    grid.start();
  }

  void addGlider(int col, int row) {
    grid.addGlider(col, row);
  }

  void addBlinker(int col, int row) {
    grid.addBlinker(col, row);
  }

  void addBlock(int col, int row) {
    grid.addBlock(col, row);
  }

  void setPatternToPlace(String pattern) {
    grid.setPatternToPlace(pattern);
  }

  void cancelPatternPlacement() {
    grid.cancelPatternPlacement();
  }
}
