import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'grid.dart';

class RedSquare extends PositionComponent with DragCallbacks {
  static const squareSize = 50.0;

  final Grid grid;

  RedSquare({
    required Vector2 position,
    required this.grid,
  })
      : super(
          position: position,
          size: Vector2(squareSize, squareSize),
          anchor: Anchor.center,
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      size.toRect(),
      Paint()..color = Colors.red,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    // Притягиваем к ближайшей клетке сетки
    position = grid.snapToGrid(position);
  }
}
