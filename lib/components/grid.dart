import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../config/constants.dart';
import 'red_square.dart';

class Grid extends PositionComponent with TapCallbacks {
  final double cellSize;
  final int cols;
  final int rows;

  late List<List<Cell>> cells;
  double elapsedTime = 0;
  static const updateInterval = 0.3; // Обновляем каждые 0.3 секунды
  bool isRunning = false; // Игра запущена?
  String? patternToPlace; // Какой паттерн сейчас ставить

  Grid({
    required this.cellSize,
    required this.cols,
    required this.rows,
  })
      : super(
          size: Vector2(cellSize * cols, cellSize * rows),
          anchor: Anchor.topLeft,
          position: Vector2.zero(),
        ) {
    _initializeCells();
  }

  void _initializeCells() {
    cells = List.generate(
      rows,
      (row) => List.generate(
        cols,
        (col) {
          // Изначально все клетки мертвы
          return Cell(col: col, row: row, alive: false);
        },
      ),
    );
    isRunning = false;
  }

  void reset() {
    _initializeCells();
    elapsedTime = 0;
  }

  void toggleCell(Vector2 position) {
    final col = (position.x / cellSize).floor();
    final row = (position.y / cellSize).floor();

    if (row >= 0 && row < rows && col >= 0 && col < cols) {
      cells[row][col].alive = !cells[row][col].alive;
    }
  }

  void start() {
    isRunning = true;
  }

  void addGlider(int startCol, int startRow) {
    // Классический паттерн Glider
    if (startRow + 2 < rows && startCol + 2 < cols) {
      cells[startRow][startCol + 1].alive = true;
      cells[startRow + 1][startCol + 2].alive = true;
      cells[startRow + 2][startCol].alive = true;
      cells[startRow + 2][startCol + 1].alive = true;
      cells[startRow + 2][startCol + 2].alive = true;
    }
  }

  void addBlinker(int startCol, int startRow) {
    // Горизонтальный Blinker (3 в ряд)
    if (startCol + 2 < cols) {
      cells[startRow][startCol].alive = true;
      cells[startRow][startCol + 1].alive = true;
      cells[startRow][startCol + 2].alive = true;
    }
  }

  void addBlock(int startCol, int startRow) {
    // Стабильный паттерн Block (квадрат 2x2)
    if (startRow + 1 < rows && startCol + 1 < cols) {
      cells[startRow][startCol].alive = true;
      cells[startRow][startCol + 1].alive = true;
      cells[startRow + 1][startCol].alive = true;
      cells[startRow + 1][startCol + 1].alive = true;
    }
  }

  void _updateGeneration() {
    // Вычисляем следующее поколение
    final newCells = List.generate(
      rows,
      (row) => List.generate(
        cols,
        (col) {
          final cell = cells[row][col];
          final nextAlive = cell.getNextState(cells);
          return Cell(col: col, row: row, alive: nextAlive);
        },
      ),
    );
    cells = newCells;
  }

  @override
  void onTapUp(TapUpEvent event) {
    final col = (event.localPosition.x / cellSize).floor();
    final row = (event.localPosition.y / cellSize).floor();

    if (row >= 0 && row < rows && col >= 0 && col < cols) {
      if (patternToPlace != null) {
        // Ставим паттерн в выбранное место
        switch (patternToPlace) {
          case 'block':
            addBlock(col, row);
            break;
          case 'blinker':
            addBlinker(col, row);
            break;
          case 'glider':
            addGlider(col, row);
            break;
        }
        // Остаемся в режиме расставления, не сбрасываем patternToPlace
      } else {
        // Просто переключаем клетку
        toggleCell(event.localPosition);
      }
    }
  }

  void setPatternToPlace(String pattern) {
    patternToPlace = pattern;
  }

  void cancelPatternPlacement() {
    patternToPlace = null;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!isRunning) return;

    elapsedTime += dt;
    if (elapsedTime >= updateInterval) {
      _updateGeneration();
      elapsedTime = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    // Рисуем клетки
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final cell = cells[row][col];
        final x = col * cellSize;
        final y = row * cellSize;

        final paint = Paint()
          ..color = cell.alive ? Colors.green : Colors.grey[800]!;

        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize, cellSize),
          paint,
        );
      }
    }

    // Рисуем сетку
    final gridPaint = Paint()
      ..color = Colors.white10
      ..strokeWidth = 0.5;

    // Вертикальные линии
    for (var i = 0; i <= cols; i++) {
      final x = i * cellSize.toDouble();
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.y),
        gridPaint,
      );
    }

    // Горизонтальные линии
    for (var i = 0; i <= rows; i++) {
      final y = i * cellSize.toDouble();
      canvas.drawLine(
        Offset(0, y),
        Offset(size.x, y),
        gridPaint,
      );
    }
  }
}
