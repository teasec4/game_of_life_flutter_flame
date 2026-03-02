import 'package:flutter/material.dart';

/// Представляет одну клетку в Grid
class Cell {
  int col;
  int row;
  bool alive;

  Cell({
    required this.col,
    required this.row,
    required this.alive,
  });

  /// Возвращает живых соседей
  int countLiveNeighbors(List<List<Cell>> grid) {
    int count = 0;
    final rows = grid.length;
    final cols = grid[0].length;

    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;

        int newRow = row + dr;
        int newCol = col + dc;

        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
          if (grid[newRow][newCol].alive) {
            count++;
          }
        }
      }
    }
    return count;
  }

  /// Применяет правила Game of Life
  bool getNextState(List<List<Cell>> grid) {
    final liveNeighbors = countLiveNeighbors(grid);

    if (alive) {
      // Живая клетка выживает при 2 или 3 соседях
      return liveNeighbors == 2 || liveNeighbors == 3;
    } else {
      // Мертвая клетка оживает при ровно 3 соседях
      return liveNeighbors == 3;
    }
  }
}
