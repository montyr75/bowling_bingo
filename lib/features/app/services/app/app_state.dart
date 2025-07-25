import 'package:dart_mappable/dart_mappable.dart';

import '../../../../data/bowler_levels.dart';

part 'app_state.mapper.dart';

@MappableClass()
class AppState with AppStateMappable{
  final BowlerLevel bowlerLevel;
  final BingoMarker bingoMarker;
  // final SavedGame? savedGame;

  const AppState({
    this.bowlerLevel = BowlerLevel.beginner,
    this.bingoMarker = BingoMarker.blueBall,
    // this.savedGame,
  });

  // bool get hasValidSave => savedGame != null && savedGame!.version == version;

  // bool get isGameActive => bowlerLevel != null;
}

const markersPath = 'assets/images/markers';

enum BingoMarker {
  blackBall(assetPath: '$markersPath/black_ball.png'),
  blueBall(assetPath: '$markersPath/blue_ball.png'),
  greenBall(assetPath: '$markersPath/green_ball.png'),
  pinkBall(assetPath: '$markersPath/pink_ball.png'),
  redBall(assetPath: '$markersPath/red_ball.png'),
  yellowBall(assetPath: '$markersPath/yellow_ball.png');

  final String assetPath;

  const BingoMarker({required this.assetPath});
}