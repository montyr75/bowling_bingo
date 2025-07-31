import 'package:dart_mappable/dart_mappable.dart';
import 'package:dartx/dartx.dart';

import '../../../data/bowling_challenges.dart';
import '../../../models/bingo_card.dart';
import '../../../models/bowling_game.dart';
import '../../../models/challenge_result.dart';

part 'game_state.mapper.dart';

@MappableClass()
class GameState with GameStateMappable {
  final int game; // the current bowling game
  final int frame;
  final Challenge? challenge; // index of space in contention
  final BingoCard card;
  final Map<int, BowlingGame> history;

  const GameState({
    this.game = 1,
    this.frame = 1,
    this.challenge,
    this.card = const BingoCard(),
    this.history = const {1: BowlingGame()},
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

  bool get isGameOver => (currentGame ?? const BowlingGame()).isGameOver;

  int get points => card.score;

  BowlingGame? get currentGame => history[game];
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

extension MapBowlingGameX on Map<int, BowlingGame> {
  List<ChallengeResultBase> get fullHistory => [
    for (final game in values) ...game.results,
  ];

  int get percentSuccess {
    final fullHistory = this.fullHistory;

    final totalChallenges = fullHistory.length;

    final totalWon = fullHistory.count((value) => value.isSuccess);

    if (totalChallenges == 0 || totalWon == 0) {
      return 0;
    }

    return (totalWon / totalChallenges * 100).round();
  }

  int get seriesTotal => values.map((game) => game.score).sum();
}
