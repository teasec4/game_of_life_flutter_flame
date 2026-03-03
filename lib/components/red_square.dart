import 'package:flutter/material.dart';

/// Представляет одну клетку в Grid (иммутабельная)
class Cell {
  final int col;
  final int row;

  const Cell({
    required this.col,
    required this.row,
  });

  /// Возвращает живых соседей
  static int countLiveNeighbors(int row, int col, List<List<bool>> alive) {
    int count = 0;
    final rows = alive.length;
    final cols = alive[0].length;

    for (int dr = -1; dr <= 1; dr++) {
      for (int dc = -1; dc <= 1; dc++) {
        if (dr == 0 && dc == 0) continue;

        int newRow = row + dr;
        int newCol = col + dc;

        if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
          if (alive[newRow][newCol]) {
            count++;
          }
        }
      }
    }
    return count;
  }

  /// Применяет правила Game of Life
  static bool getNextState(int row, int col, bool currentAlive, List<List<bool>> alive) {
    final liveNeighbors = countLiveNeighbors(row, col, alive);

    if (currentAlive) {
      // Живая клетка выживает при 2 или 3 соседях
      return liveNeighbors == 2 || liveNeighbors == 3;
    } else {
      // Мертвая клетка оживает при ровно 3 соседях
      return liveNeighbors == 3;
    }
  }
}
