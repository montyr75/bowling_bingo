import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'features/app/presentation/home_page.dart';
import 'features/app/presentation/not_found_page.dart';
import 'features/bingo/presentation/bingo_page.dart';

part 'routes.g.dart';

enum AppRoute {
  home('/'),
  game('/game');

  final String? _path;

  String get path => _path ?? name;

  const AppRoute([this._path]);
}

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: false,
    routerNeglect: true,
    initialLocation: AppRoute.home.path,
    observers: [FlutterSmartDialog.observer],
    // redirect: (context, state) {
    //   final appState = ref.read(appServiceProvider);
    //
    //   // if the app starts on a deep link with an uninitialized app state, redirect home
    //   if (appState.isGameActive) {
    //     return null;
    //   }
    //   else {
    //     return '/';
    //   }
    // },
    routes: [
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: AppRoute.game.name,
            path: AppRoute.game.path,
            builder: (context, state) => const BingoPage(),
            // routes: [
            //   GoRoute(
            //     name: AppRoute.characterDetails.name,
            //     path: AppRoute.characterDetails.path,
            //     builder: (context, state) =>
            //         CharacterDetailsPage(character: state.extra as Character),
            //   ),
            // ],
          ),
          // GoRoute(
          //   name: AppRoute.corridor.name,
          //   path: AppRoute.corridor.path,
          //   builder: (context, state) => const CorridorPage(),
          //   routes: [
          //     GoRoute(
          //       name: AppRoute.room.name,
          //       path: AppRoute.room.path,
          //       builder: (context, state) => const RoomPage(),
          //     ),
          //     GoRoute(
          //       name: AppRoute.lair.name,
          //       path: AppRoute.lair.path,
          //       builder: (context, state) => const LairPage(),
          //     ),
          //     GoRoute(
          //       name: AppRoute.bossLair.name,
          //       path: AppRoute.bossLair.path,
          //       builder: (context, state) => const BossLairPage(),
          //     ),
          //      GoRoute(
          //       name: AppRoute.tavern.name,
          //       path: AppRoute.tavern.path,
          //       builder: (context, state) => const TavernPage(),
          //     ),
          //     GoRoute(
          //       name: AppRoute.fork.name,
          //       path: AppRoute.fork.path,
          //       builder: (context, state) => const ForkPage(),
          //     ),
          //    GoRoute(
          //       name: AppRoute.treasureRoom.name,
          //       path: AppRoute.treasureRoom.path,
          //       builder: (context, state) => const TreasureRoomPage(),
          //     ),
          //   ],
          // ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
