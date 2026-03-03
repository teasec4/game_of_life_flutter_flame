import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:second_touch/game/grid/grid_size.dart';

class StartPage extends StatelessWidget {
  final List<GridSizeConfig> gridSizeConfigOptions;

  const StartPage({super.key, required this.gridSizeConfigOptions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configuration")),
      body: ListView.builder(
        itemCount: gridSizeConfigOptions.length,
        itemBuilder: (context, index) {
          final gridOption = gridSizeConfigOptions[index];
          return ListTile(
            title: Text(gridOption.name),
            subtitle: Text(
              "cols: ${gridOption.cols}, rows: ${gridOption.rows}, cell size: ${gridOption.cellSize}",
            ),
            onTap: () {
              context.go('/start/game/${gridOption.name}');
            },
          );
        },
      ),
    );
  }
}
