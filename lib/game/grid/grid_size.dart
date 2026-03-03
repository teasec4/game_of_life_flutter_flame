class GridSizeConfig {
  final String name;
  final double cellSize;
  final int cols;
  final int rows;

  const GridSizeConfig({
    required this.name,
    required this.cellSize,
    required this.cols,
    required this.rows,
  });
}

const List<GridSizeConfig> gridVariant = [
  GridSizeConfig(
    name: 'Small',
    cellSize: 108.0,
    cols: 5,
    rows: 9,
  ),
  GridSizeConfig(
    name: 'Medium',
    cellSize: 54.0,
    cols: 10,
    rows: 18,
  ),
  GridSizeConfig(
    name: 'Large',
    cellSize: 27.0,
    cols: 20,
    rows: 36,
  ),
  GridSizeConfig(
    name: 'Huge',
    cellSize: 10.0,
    cols: 100,
    rows: 150,
  ),
  GridSizeConfig(
    name: 'Infinite',
    cellSize: 8.0,
    cols: 200,
    rows: 300,
  ),
];
