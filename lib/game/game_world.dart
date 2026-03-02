import 'package:flame/components.dart';
import '../components/grid.dart';
import '../components/red_square.dart';

class GameWorld extends World {
  late Grid grid;
  late RedSquare redSquare;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Инициализируем сетку
    grid = Grid();
    add(grid);

    // Инициализируем красный квадрат на клетке [2, 2]
    final startPosition = grid.getCellCenter(2, 2);
    redSquare = RedSquare(
      position: startPosition,
      grid: grid,
    );
    add(redSquare);
  }
}
