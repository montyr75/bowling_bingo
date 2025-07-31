import 'package:collection/collection.dart' hide IterableNullableExtension, IterableIntegerExtension;
import 'package:dart_mappable/dart_mappable.dart';
import 'package:dartx/dartx.dart';

import 'challenge_result.dart';
import 'frame.dart';

part 'bowling_game.mapper.dart';

@MappableClass()
class BowlingGame with BowlingGameMappable {
  final List<ChallengeResultBase> results;

  const BowlingGame({
    this.results = const [],
  });

  BowlingGame add(ChallengeResultBase result) {
    final newResults = results.toList()..add(result);

    return copyWith(
      results: List.unmodifiable(newResults.updateScore()),
    );
  }

  bool get isGameOver => results.length == 10;

  int get totalWon => results.count((value) => value.isSuccess);

  int get percentSuccess {
    final totalChallenges = results.length;
    final totalWon = this.totalWon;

    if (totalChallenges == 0 || totalWon == 0) {
      return 0;
    }

    return (totalWon / totalChallenges * 100).round();
  }

  int get percentFailure {
    if (results.isEmpty) {
      return 0;
    }

    return 100 - percentSuccess;
  }

  int get score {
    final result = results.lastWhereOrNull((result) => result.hasScore);

    if (result != null) {
      return result.frameData.score!;
    }

    return 0;
  }
}

extension ListChallengeResultX on List<ChallengeResultBase> {
  List<ChallengeResultBase> updateScore() {
    int score = 0;

    final frames = map((result) => result.frameData).toList();

    return map((result) {
      final frameScore = _scoreFrame(result.frame - 1, frames);

      if (frameScore != null) {
        return result.copyWith(
          frameData: result.frameData.copyWith(
            score: score += frameScore,
          ),
        );
      }

      return result;
    }).toList();
  }

  int? _scoreFrame(int frameIndex, List<Frame> frames) {
    final frame = frames[frameIndex];

    int? score;

    if (frame is TenthFrame) {
      if (frame.isStrike) {
        final nextTwoThrows = frame.throws.skip(1).whereNotNull();
        score = 10 + nextTwoThrows.sum();
      } else if (frame.isSpare) {
        score = 10 + (frame.thirdThrow ?? 0);
      } else {
        score = frame.throws.whereNotNull().sum();
      }
    } else {
      final nextTwoThrows = [
        if (frames.length >= frameIndex + 2) ...frames[frameIndex + 1].throws,
        if (frames.length >= frameIndex + 3) ...frames[frameIndex + 2].throws,
      ].whereNotNull().take(2);

      if (frame.isStrike) {
        if (nextTwoThrows.length == 2) {
          score = 10 + nextTwoThrows.sum();
        }
      } else if (frame.isSpare) {
        if (nextTwoThrows.isNotEmpty) {
          score = 10 + nextTwoThrows.first;
        }
      } else {
        score = frame.throws.whereNotNull().sum();
      }
    }

    return score;
  }
}