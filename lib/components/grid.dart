import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'red_square.dart';

class Grid extends PositionComponent with TapCallbacks {
  final double cellSize;
  final int cols;
  final int rows;
  double updateInterval; // Интервал обновления в секундах

  // Храним состояние клеток отдельно для оптимизации памяти
  late List<List<Cell>> cells;
  late List<List<bool>> alive;
  
  double elapsedTime = 0;
  bool isRunning = false; // Игра запущена?
  String? patternToPlace; // Какой паттерн сейчас ставить

  Grid({
    required this.cellSize,
    required this.cols,
    required this.rows,
    this.updateInterval = 0.3,
  })
      : super(
          size: Vector2(cellSize * cols, cellSize * rows),
          anchor: Anchor.topLeft,
          position: Vector2.zero(),
        ) {
    _initializeCells();
  }

  void _initializeCells() {
    // Создаём иммутабельные Cell объекты один раз
    cells = List.generate(
      rows,
      (row) => List.generate(
        cols,
        (col) => Cell(col: col, row: row),
      ),
    );
    // Инициализируем состояние (все клетки изначально мертвы)
    alive = List.generate(
      rows,
      (row) => List.generate(cols, (col) => false),
    );
    isRunning = false;
  }

  void reset() {
    _initializeCells();
    elapsedTime = 0;
  }

  /// Конвертирует локальную позицию в координаты ячейки (col, row)
  /// Возвращает null если позиция за границами сетки
  ({int col, int row})? toCellPosition(Vector2 localPosition) {
    final col = (localPosition.x / cellSize).floor();
    final row = (localPosition.y / cellSize).floor();

    if (row >= 0 && row < rows && col >= 0 && col < cols) {
      return (col: col, row: row);
    }
    return null;
  }

  void toggleCell(Vector2 position) {
    final cell = toCellPosition(position);
    if (cell != null) {
      alive[cell.row][cell.col] = !alive[cell.row][cell.col];
    }
  }

  void start() {
    isRunning = true;
  }

  void addGlider(int startCol, int startRow) {
    // Классический паттерн Glider
    if (startRow + 2 < rows && startCol + 2 < cols) {
      alive[startRow][startCol + 1] = true;
      alive[startRow + 1][startCol + 2] = true;
      alive[startRow + 2][startCol] = true;
      alive[startRow + 2][startCol + 1] = true;
      alive[startRow + 2][startCol + 2] = true;
    }
  }

  void addBlinker(int startCol, int startRow) {
    // Горизонтальный Blinker (3 в ряд)
    if (startCol + 2 < cols) {
      alive[startRow][startCol] = true;
      alive[startRow][startCol + 1] = true;
      alive[startRow][startCol + 2] = true;
    }
  }

  void addBlock(int startCol, int startRow) {
    // Стабильный паттерн Block (квадрат 2x2)
    if (startRow + 1 < rows && startCol + 1 < cols) {
      alive[startRow][startCol] = true;
      alive[startRow][startCol + 1] = true;
      alive[startRow + 1][startCol] = true;
      alive[startRow + 1][startCol + 1] = true;
    }
  }

  void addToad(int startCol, int startRow) {
    // Осцилятор периода 2
    if (startRow + 1 < rows && startCol + 3 < cols) {
      alive[startRow][startCol + 1] = true;
      alive[startRow][startCol + 2] = true;
      alive[startRow][startCol + 3] = true;
      alive[startRow + 1][startCol] = true;
      alive[startRow + 1][startCol + 1] = true;
      alive[startRow + 1][startCol + 2] = true;
    }
  }

  void addBeacon(int startCol, int startRow) {
    // Осцилятор периода 2 (два квадрата 2x2 по диагонали)
    if (startRow + 3 < rows && startCol + 3 < cols) {
      alive[startRow][startCol] = true;
      alive[startRow][startCol + 1] = true;
      alive[startRow + 1][startCol] = true;
      alive[startRow + 1][startCol + 1] = true;
      alive[startRow + 2][startCol + 2] = true;
      alive[startRow + 2][startCol + 3] = true;
      alive[startRow + 3][startCol + 2] = true;
      alive[startRow + 3][startCol + 3] = true;
    }
  }

  void addBeehive(int startCol, int startRow) {
    // Стабильный паттерн (похож на улей)
    if (startRow + 2 < rows && startCol + 3 < cols) {
      alive[startRow][startCol + 1] = true;
      alive[startRow][startCol + 2] = true;
      alive[startRow + 1][startCol] = true;
      alive[startRow + 1][startCol + 3] = true;
      alive[startRow + 2][startCol + 1] = true;
      alive[startRow + 2][startCol + 2] = true;
    }
  }

  void addPentomino(int startCol, int startRow) {
    // R-пентомино (нестабильный, интересный для наблюдения)
    if (startRow + 2 < rows && startCol + 2 < cols) {
      alive[startRow][startCol + 1] = true;
      alive[startRow][startCol + 2] = true;
      alive[startRow + 1][startCol] = true;
      alive[startRow + 1][startCol + 1] = true;
      alive[startRow + 2][startCol + 1] = true;
    }
  }

  void _updateGeneration() {
    // Вычисляем следующее поколение, обновляя существующую матрицу
    final newAlive = List.generate(
      rows,
      (row) => List.generate(
        cols,
        (col) => Cell.getNextState(row, col, alive[row][col], alive),
      ),
    );
    // Заменяем состояние только один раз вместо копирования всех Cell объектов
    alive = newAlive;
  }

  @override
  void onTapUp(TapUpEvent event) {
    final cell = toCellPosition(event.localPosition);
    if (cell == null) return;

    if (patternToPlace != null) {
      // Ставим паттерн в выбранное место
      switch (patternToPlace) {
        case 'block':
          addBlock(cell.col, cell.row);
          break;
        case 'blinker':
          addBlinker(cell.col, cell.row);
          break;
        case 'glider':
          addGlider(cell.col, cell.row);
          break;
        case 'toad':
          addToad(cell.col, cell.row);
          break;
        case 'beacon':
          addBeacon(cell.col, cell.row);
          break;
        case 'beehive':
          addBeehive(cell.col, cell.row);
          break;
        case 'pentomino':
          addPentomino(cell.col, cell.row);
          break;
      }
      // Остаемся в режиме расставления, не сбрасываем patternToPlace
    } else {
      // Просто переключаем клетку
      toggleCell(event.localPosition);
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
        final isAlive = alive[row][col];
        final x = col * cellSize;
        final y = row * cellSize;

        final paint = Paint()
          ..color = isAlive ? Colors.green : Colors.grey[800]!;

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
