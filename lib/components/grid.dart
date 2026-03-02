import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../config/constants.dart';

class Grid extends PositionComponent {
  static const cellSize = gridCellSize;
  static const cols = gridCols;
  static const rows = gridRows;

  Grid()
      : super(
          size: Vector2(cellSize * cols, cellSize * rows),
          anchor: Anchor.topLeft,
          position: Vector2.zero(),
        );

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 1;

    // Вертикальные линии
    for (var i = 0; i <= cols; i++) {
      final x = i * cellSize;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.y),
        paint,
      );
    }

    // Горизонтальные линии
    for (var i = 0; i <= rows; i++) {
      final y = i * cellSize;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.x, y),
        paint,
      );
    }
  }

  Vector2 snapToGrid(Vector2 position) {
    final col = (position.x / cellSize).floor();
    final row = (position.y / cellSize).floor();
    return Vector2(col * cellSize + cellSize / 2, row * cellSize + cellSize / 2);
  }

  Vector2 getCellCenter(int col, int row) {
    return Vector2(col * cellSize + cellSize / 2, row * cellSize + cellSize / 2);
  }
}
