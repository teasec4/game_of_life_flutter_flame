import 'package:flutter/material.dart';

class DirectionControl extends StatelessWidget {
  final VoidCallback onUp;
  final VoidCallback onDown;
  final VoidCallback onLeft;
  final VoidCallback onRight;
  final VoidCallback onStop;

  const DirectionControl({
    super.key,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade700,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildArrow(Icons.arrow_upward_rounded, onUp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildArrow(Icons.arrow_back_rounded, onLeft),
                _buildArrow(Icons.arrow_forward_rounded, onRight),
              ],
            ),
            _buildArrow(Icons.arrow_downward_rounded, onDown),
          ],
        ),
      ),
    );
  }
  
  Widget _buildArrow(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTapDown: (_) => onPressed(),
      onTapUp: (_) => onStop(),
      onTapCancel: onStop,
      child: Icon(icon, color: Colors.white),
    );
  }
}
