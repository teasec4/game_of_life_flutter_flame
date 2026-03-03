import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:second_touch/game/my_game.dart';

class GameViewModel extends ChangeNotifier {
  final MyGame game;

  GameViewModel(this.game);

  String? selectedPattern;

  void start() {
    game.startGame();
  }

  void reset() {
    game.resetGame();
    selectedPattern = null;
    notifyListeners();
  }

  void setSpeed(double speed) {
    game.setUpdateInterval(speed);
  }

  void zoomIn() {
    game.zoomIn();
  }

  void zoomOut() {
    game.zoomOut();
  }

  void startMoving(Vector2 direction) {
    game.startMoving(direction);
  }
  
  // void moveLeft() {
  //   startMoving(Vector2(-1, 0));
  // }
  
  // void moveRight() {
  //   startMoving(Vector2(1, 0));
  // }
  
  // void moveUp() {
  //   startMoving(Vector2(0, -1));
  // }
  
  // void moveDown() {
  //   startMoving(Vector2(0, 1));
  // }

  void stopMoving() {
    game.stopMoving();
  }

  void selectPattern(String pattern) {
    selectedPattern = pattern;
    game.setPatternToPlace(pattern);
    notifyListeners();
  }

  void cancelPattern() {
    selectedPattern = null;
    game.cancelPatternPlacement();
    notifyListeners();
  }
}
