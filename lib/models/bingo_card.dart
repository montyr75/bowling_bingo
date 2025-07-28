import 'package:dart_mappable/dart_mappable.dart';

import '../utils/utils.dart';

part 'bingo_card.mapper.dart';

@MappableClass()
class BingoCard with BingoCardMappable {
  static const winConditions = {
    5: [
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
    ],
  };

  final int extent;
  final List<Space> spaces;

  const BingoCard({
    this.extent = 5,
    this.spaces = const [],
  });

  factory BingoCard.init({int extent = 5, bool shouldMarkCenter = true}) {
    BingoCard card = BingoCard(
      extent: extent,
      spaces: List.unmodifiable(
        List.generate(extent * extent, (index) => Space(index: index)),
      ),
    );

    if (shouldMarkCenter) {
      card = card.markSpace(card.centerIndex);
    }

    return card.setRandomBonusSpace();
  }

  bool get isBingo {
    final markedList = spaces.map((space) => space.isMarked).toList();

    for (final line in winConditions[extent]!) {
      if (line.every((index) => markedList[index])) {
        return true;
      }
    }

    return false;
  }

  BingoCard setSpaceState(int index, SpaceState state) {
    final space = spaces[index].copyWith(state: state);

    return copyWith(
      spaces: List.unmodifiable(spaces.toList()..replaceAt(index, space)),
    );
  }

  BingoCard setSpacePointsMultiplier(int index, int multiplier) {
    final space = spaces[index].copyWith(pointsMultiplier: multiplier);

    return copyWith(
      spaces: List.unmodifiable(spaces.toList()..replaceAt(index, space)),
    );
  }

  BingoCard markSpace(int index) => setSpaceState(index, SpaceState.marked);

  BingoCard markRandomSpace() => setSpaceState(getRandomUnmarkedSpace().index, SpaceState.marked);

  List<Space> getUnmarkedSpaces() => spaces.where((space) => !space.isMarked).toList();

  Space getRandomUnmarkedSpace() {
    final unmarkedSpaces = getUnmarkedSpaces()..shuffle();
    return unmarkedSpaces.first;
  }

  BingoCard setRandomBonusSpace() => setSpaceState(getRandomUnmarkedSpace().index, SpaceState.bonus);

  int get centerIndex => (extent * extent) ~/ 2;

  int get score {
    int total = 0;

    for (final space in spaces) {
      total += _calculateSpaceScore(index: space.index, extent: extent);
    }

    return total;
  }

  int _calculateSpaceScore({required int index, int extent = 5}) {
    final space = spaces[index];

    if (!space.isMarked) {
      return 0;
    }

    int adjacentCount = 0;
    final row = index ~/ extent;
    final col = index % extent;

    for (int rOffset = -1; rOffset <= 1; rOffset++) {
      for (int cOffset = -1; cOffset <= 1; cOffset++) {
        final neighborRow = row + rOffset;
        final neighborCol = col + cOffset;

        if (neighborRow >= 0 && neighborRow < extent && neighborCol >= 0 && neighborCol < extent) {
          final neighborIndex = neighborRow * extent + neighborCol;

          if (spaces[neighborIndex].isMarked) {
            adjacentCount++;
          }
        }
      }
    }

    return adjacentCount * space.pointsMultiplier;
  }

  Space operator [](int index) => spaces[index];
}

@MappableClass()
class Space with SpaceMappable {
  final int index;
  final SpaceState state;
  final int pointsMultiplier;

  const Space({
    required this.index,
    this.state = SpaceState.unmarked,
    this.pointsMultiplier = 1,
  });

  bool get isMarked => state == SpaceState.marked;

  bool get isUnmarked => state == SpaceState.unmarked;

  bool get isBonus => state == SpaceState.bonus;

  bool get hasPointsMultiplier => pointsMultiplier > 1;
}

@MappableEnum()
enum SpaceState {
  unmarked,
  marked,
  bonus,
}

//  0  1  2  3  4
//  5  6  7  8  9
// 10 11 12 13 14
// 15 16 17 18 19
// 20 21 22 23 24
