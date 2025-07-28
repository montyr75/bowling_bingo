import 'package:dart_mappable/dart_mappable.dart';

import '../../../data/bowling_challenges.dart';
import '../../../models/bingo_card.dart';
import '../../../models/challenge_result.dart';

part 'game_state.mapper.dart';

@MappableClass()
class GameState with GameStateMappable {
  final int game; // the current bowling game
  final int frame;
  final Challenge? challenge; // index of space in contention
  final BingoCard card;
  final Map<int, List<ChallengeResultBase>> history;

  const GameState({
    this.game = 1,
    this.frame = 1,
    this.challenge,
    this.card = const BingoCard(),
    this.history = const {},
  });

  GameState init({int extent = 5}) {
    return copyWith(
      card: BingoCard.init(extent: extent),
    );
  }

  GameState clearChallenge() {
    return GameState(
      game: game,
      frame: frame,
      card: card,
      history: history,
    );
  }

  bool get hasChallenge => challenge != null;

  bool get isGameOver => (history[game] ?? const []).length == 10;

  int get points => card.score;
}

@MappableClass()
class Challenge with ChallengeMappable {
  final int space;
  final BowlingChallenge challenge;
  final int? strength;

  const Challenge({
    required this.space,
    required this.challenge,
    this.strength,
  });
}
