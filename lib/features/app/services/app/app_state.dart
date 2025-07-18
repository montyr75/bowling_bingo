import 'package:dart_mappable/dart_mappable.dart';

import '../../../../data/bowler_levels.dart';

part 'app_state.mapper.dart';

@MappableClass()
class AppState with AppStateMappable{
  final BowlerLevel bowlerLevel;
  // final SavedGame? savedGame;

  const AppState({
    this.bowlerLevel = BowlerLevel.beginner,
    // this.savedGame,
  });

  // bool get hasValidSave => savedGame != null && savedGame!.version == version;

  // bool get isGameActive => bowlerLevel != null;
}
