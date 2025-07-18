import 'package:dart_mappable/dart_mappable.dart';

import '../../../data/bowling_challenges.dart';
import '../../../models/challenge_result.dart';
import '../../../utils/utils.dart';

part 'game_state.mapper.dart';

@MappableClass()
class GameState with GameStateMappable {
  final int game;   // the current bowling game
  final int frame;
  final Challenge? challenge;  // index of space in contention
  final int points;
  final List<Space> card;
  final Map<int, List<ChallengeResultBase>> history;

  const GameState({
    this.game = 1,
    this.frame = 1,
    this.challenge,
    this.points = 0,
    this.card = const [],
    this.history = const {},
  });

  factory GameState.initialize5By5({int game = 1}) {
    final card = List.generate(25, (index) => Space(index: index)).markSpace(12);

    return GameState(
      game: game,
      card: card,
      points: card.calculateScore(),
    );
  }

  GameState clearChallenge() {
    return GameState(
      game: game,
      frame: frame,
      points: points,
      card: card,
      history: history,
    );
  }

  bool get hasChallenge => challenge != null;
}

@MappableClass()
class Space with SpaceMappable {
  final int index;
  final bool isMarked;

  const Space({
    required this.index,
    this.isMarked = false,
  });
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

const List<List<int>> bingoWinConditions5x5 = [
  // Rows
  [0, 1, 2, 3, 4],
  [5, 6, 7, 8, 9],
  [10, 11, 12, 13, 14],
  [15, 16, 17, 18, 19],
  [20, 21, 22, 23, 24],
  // Columns
  [0, 5, 10, 15, 20],
  [1, 6, 11, 16, 21],
  [2, 7, 12, 17, 22],
  [3, 8, 13, 18, 23],
  [4, 9, 14, 19, 24],
  // Diagonals
  [0, 6, 12, 18, 24],
  [4, 8, 12, 16, 20],
];

extension ListSpaceX on List<Space> {
  List<Space> markSpace(int index) {
    final space = this[index].copyWith(isMarked: true);
    return List.unmodifiable(toList()..replaceAt(index, space));
  }

  bool hasBingo(List<List<int>> winConditions) {
    final markedList = map((space) => space.isMarked).toList();

    for (final line in winConditions) {
      if (line.every((index) => markedList[index])) {
        return true;
      }
    }

    return false;
  }

  int calculateScore({int extent = 5}) {
    int total = 0;

    for (final space in this) {
      total += calculateSpaceScore(index: space.index, extent: extent);
    }

    return total;
  }

  int calculateSpaceScore({required int index, int extent = 5}) {
    if (!this[index].isMarked) {
      return 0;
    }

    int adjacentCount = 0;
    final row = index ~/ extent;
    final col = index % extent;

    for (int rOffset = -1; rOffset <= 1; rOffset++) {
      for (int cOffset = -1; cOffset <= 1; cOffset++) {
        final neighborRow = row + rOffset;
        final neighborCol = col + cOffset;

        if (neighborRow >= 0 &&
            neighborRow < extent &&
            neighborCol >= 0 &&
            neighborCol < extent) {
          final neighborIndex = neighborRow * extent + neighborCol;

          if (this[neighborIndex].isMarked) {
            adjacentCount++;
          }
        }
      }
    }

    return adjacentCount;
  }
}

//  0  1  2  3  4
//  5  6  7  8  9
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24