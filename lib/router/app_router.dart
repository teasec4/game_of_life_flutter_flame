import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:second_touch/application/grid_config_provider.dart';
import 'package:second_touch/presentation/pages/game_page/game_page.dart';
import 'package:second_touch/presentation/pages/start_page/start_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, state) => StartPage(gridSizeConfigOptions: context.read<GridConfigProvider>().gridSizeConfig,),
        // routes: [
        //   GoRoute(
        //     path: '/game',
        //     builder: (context, state) => const GamePage()
        //   ),
        // ]
      ),
      
    ]
  );
}
