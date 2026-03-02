// Портретная ориентация (для мобильных телефонов)
const gameWidth = 540.0;   // Ширина экрана
const gameHeight = 960.0;  // Высота экрана

// Конфигурации сетки
const gridCellSize = 54.0;  // 540 / 10
const gridCols = 10;        // 10 колонок
const gridRows = 18;        // 960 / 54 = ~17.8, берём 18

// Предустановки размеров
class GridConfig {
  final String name;
  final double cellSize;
  final int cols;
  final int rows;

  const GridConfig({
    required this.name,
    required this.cellSize,
    required this.cols,
    required this.rows,
  });
}

const List<GridConfig> gridConfigs = [
  GridConfig(
    name: 'Small',
    cellSize: 27.0,
    cols: 20,
    rows: 36,
  ),
  GridConfig(
    name: 'Medium',
    cellSize: 54.0,
    cols: 10,
    rows: 18,
  ),
  GridConfig(
    name: 'Large',
    cellSize: 108.0,
    cols: 5,
    rows: 9,
  ),
];
