import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_touch/application/game_view_model.dart';
import 'package:second_touch/application/grid_config_provider.dart';
import 'package:second_touch/router/app_router.dart';

void main() {
  runApp(
    MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_) => GridConfigProvider(),),
          
     ],
    child: const App(), 
    )
    
  );
}

class App extends StatelessWidget{
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Game Of Life',
      debugShowCheckedModeBanner: false,
      // theme: ,
      routerConfig: AppRouter.router,
    );
  }
}

