// Портретная ориентация (для мобильных телефонов)
const gameWidth = 540.0;   // Ширина экрана
const gameHeight = 960.0;  // Высота экрана

// Предустановки размеров сетки
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
    cellSize: 108.0,
    cols: 5,
    rows: 9,
  ),
  GridConfig(
    name: 'Medium',
    cellSize: 54.0,
    cols: 10,
    rows: 18,
  ),
  GridConfig(
    name: 'Large',
    cellSize: 27.0,
    cols: 20,
    rows: 36,
  ),
  GridConfig(
    name: 'Huge',
    cellSize: 10.0,
    cols: 100,
    rows: 150,
  ),
  GridConfig(
    name: 'Infinite',
    cellSize: 8.0,
    cols: 200,
    rows: 300,
  ),
];
