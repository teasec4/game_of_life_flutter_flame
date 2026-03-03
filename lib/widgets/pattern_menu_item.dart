import 'package:flutter/material.dart';

class PatternMenuItem extends StatelessWidget {
  final String name;
  final List<List<bool>> pattern;
  final double cellSize;

  const PatternMenuItem({
    super.key,
    required this.name,
    required this.pattern,
    this.cellSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          // Pattern grid visualization
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(2),
            ),
            child: SizedBox(
              width: cellSize * pattern[0].length + 2,
              height: cellSize * pattern.length + 2,
              child: GridView.builder(
                padding: const EdgeInsets.all(1),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: pattern[0].length,
                  childAspectRatio: 1,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                itemCount: pattern.length * pattern[0].length,
                itemBuilder: (context, index) {
                  final row = index ~/ pattern[0].length;
                  final col = index % pattern[0].length;
                  final isAlive = pattern[row][col];

                  return Container(
                    decoration: BoxDecoration(
                      color: isAlive ? Colors.green : Colors.grey[300],
                      border: Border.all(
                        color: Colors.grey[400]!,
                        width: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Pattern name
          Text(name),
        ],
      ),
    );
  }
}

/// Паттерны для меню
const patternVisualizations = {
  'block': [
    [true, true],
    [true, true],
  ],
  'blinker': [
    [false, false, false],
    [true, true, true],
    [false, false, false],
  ],
  'glider': [
    [false, true, false],
    [false, false, true],
    [true, true, true],
  ],
  'toad': [
    [false, true, true, true],
    [true, true, true, false],
  ],
  'beacon': [
    [true, true, false, false],
    [true, true, false, false],
    [false, false, true, true],
    [false, false, true, true],
  ],
  'beehive': [
    [false, true, true, false],
    [true, false, false, true],
    [false, true, true, false],
  ],
  'pentomino': [
    [false, true, true],
    [true, true, false],
    [false, true, false],
  ],
};
