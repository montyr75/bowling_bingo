import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';

import '../models/frame.dart';
import '../utils/roller.dart';
import '../utils/utils.dart';

part 'bowling_challenges.mapper.dart';

typedef ChallengeEvaluation = bool Function({required Frame frame, int? strength});

@MappableEnum()
enum BowlingHit {
  strike,
  spare,
  min1,
  min;

  String toDisplay([int? strength]) {
    return switch (this) {
      BowlingHit.strike => "X",
      BowlingHit.spare => "/",
      BowlingHit.min1 => "1+",
      BowlingHit.min => "$strength+",
    };
  }
}

@MappableClass()
class BowlingChallenge with BowlingChallengeMappable {
  final int level;
  final bool isVariable; // does this challenge require a strength input?
  final BowlingHit? firstThrow;
  final BowlingHit? secondThrow;
  final BowlingHit? frameTotal;
  final String description;

  const BowlingChallenge({
    required this.level,
    this.isVariable = false,
    this.firstThrow,
    this.secondThrow,
    this.frameTotal,
    required this.description,
  });

  String toDisplay([int? strength]) {
    if (!isVariable) {
      return description;
    }

    assert(strength != null);

    return description.replaceAll("#", strength.toString());
  }

  bool evaluate({required Frame frame, int? strength}) {
    return bowlingChallengeEvaluators[level - 1](frame: frame, strength: strength);
  }

  static BowlingChallenge generateBowlingChallenge({required int level, int strength = 0, int mod = 0}) {
    final challenges = bowlingChallenges.take(level).toList();
    final roll = rand(challenges.length) + mod;

    BowlingChallenge challenge = challenges[roll.maxOf(challenges.length - 1)];

    if (challenge.isVariable) {
      // a strength of 10 (or 9 and 1) requires the player to strike or spare
      if (strength == 10) {
        if (challenge.firstThrow == BowlingHit.min) {
          challenge = bowlingChallenges.last;
        } else if (challenge.frameTotal == BowlingHit.min) {
          challenge = bowlingChallenges.getByLevel(6)!;
        }
      } else if (strength == 9 && challenge.secondThrow == BowlingHit.min1) {
        challenge = bowlingChallenges.getByLevel(6)!;
      }
    }

    return challenge;
  }
}

@MappableClass()
class TenthFrameBowlingChallenge extends BowlingChallenge with TenthFrameBowlingChallengeMappable {
  final BowlingHit? thirdThrow;

  const TenthFrameBowlingChallenge({
    required super.level,
    super.isVariable = false,
    super.firstThrow,
    super.secondThrow,
    this.thirdThrow,
    super.frameTotal,
    required super.description,
  });

  @override
  bool evaluate({required Frame frame, int? strength}) {
    return tenthFrameBowlingChallengeEvaluators[level - 1](frame: frame, strength: strength);
  }

  static TenthFrameBowlingChallenge generateBowlingChallenge({required int level, int mod = 0, int strength = 0}) {
    final challenges = tenthFrameBowlingChallenges.take(level).toList();
    final roll = rand(challenges.length) + mod;

    TenthFrameBowlingChallenge challenge = challenges[roll.maxOf(challenges.length - 1)];

    if (challenge.isVariable) {
      // a strength of 10 (or 9 and 1) requires the player to strike or spare
      if (strength == 10) {
        if (challenge.firstThrow == BowlingHit.min) {
          challenge = tenthFrameBowlingChallenges.getByLevel(6)!;
        }
      } else if (strength == 9 && challenge.secondThrow == BowlingHit.min1) {
        challenge = tenthFrameBowlingChallenges.getByLevel(4)!;
      }
    }

    return challenge;
  }
}

/// There are 8 bowling challenges, corresponding to monster levels. A level 2 monster uses 1 or 2.
final bowlingChallenges = List<BowlingChallenge>.unmodifiable(const [
  BowlingChallenge(
    level: 1,
    firstThrow: BowlingHit.min1,
    description: "Hit at least 1 pin with the first throw.",
  ),
  BowlingChallenge(
    level: 2,
    firstThrow: BowlingHit.min1,
    secondThrow: BowlingHit.min1,
    description: "Hit at least 1 pin with each throw.",
  ),
  BowlingChallenge(
    level: 3,
    isVariable: true,
    frameTotal: BowlingHit.min,
    description: "Hit at least # total pins.",
  ),
  BowlingChallenge(
    level: 4,
    isVariable: true,
    firstThrow: BowlingHit.min,
    description: "Hit at least # pins with the first throw.",
  ),
  BowlingChallenge(
    level: 5,
    isVariable: true,
    firstThrow: BowlingHit.min,
    secondThrow: BowlingHit.min1,
    description: "Hit at least # pins with the first throw and at least 1 pin with the second throw.",
  ),
  BowlingChallenge(
    level: 6,
    secondThrow: BowlingHit.spare,
    description: "Get a spare.",
  ),
  BowlingChallenge(
    level: 7,
    isVariable: true,
    firstThrow: BowlingHit.min,
    secondThrow: BowlingHit.spare,
    description: "Hit at least # pins with the first throw and spare.",
  ),
  BowlingChallenge(
    level: 8,
    firstThrow: BowlingHit.strike,
    description: "Get a strike.",
  ),
]);

extension ListBowlingChallegeX on List<BowlingChallenge> {
  BowlingChallenge? getByLevel(int lvl) => bowlingChallenges.firstWhereOrNull((value) => value.level == lvl);
}

final tenthFrameBowlingChallenges = List<TenthFrameBowlingChallenge>.unmodifiable(const [
  TenthFrameBowlingChallenge(
    level: 1,
    firstThrow: BowlingHit.min1,
    secondThrow: BowlingHit.min1,
    thirdThrow: BowlingHit.min1,
    description: "Hit at least 1 pin with every throw (including the third throw, if there is one).",
  ),
  TenthFrameBowlingChallenge(
    level: 2,
    isVariable: true,
    firstThrow: BowlingHit.min,
    description: "Hit at least # pins on the first throw.",
  ),
  TenthFrameBowlingChallenge(
    level: 3,
    secondThrow: BowlingHit.spare,
    description: "Get a spare on either the second or third throw.",
  ),
  TenthFrameBowlingChallenge(
    level: 4,
    isVariable: true,
    firstThrow: BowlingHit.min,
    secondThrow: BowlingHit.spare,
    description: "Hit at least # pins on the first throw and spare with the second or third throw.",
  ),
  TenthFrameBowlingChallenge(
    level: 5,
    isVariable: true,
    firstThrow: BowlingHit.min,
    secondThrow: BowlingHit.spare,
    thirdThrow: BowlingHit.min,
    description:
        "Hit at least # pins on the first throw, spare on the second throw, and hit at least # pins on the third throw.",
  ),
  TenthFrameBowlingChallenge(
    level: 6,
    firstThrow: BowlingHit.strike,
    description: "Get a strike with at least one throw.",
  ),
  TenthFrameBowlingChallenge(
    level: 7,
    firstThrow: BowlingHit.strike,
    secondThrow: BowlingHit.strike,
    description: "Get a strike with at least two throws.",
  ),
  TenthFrameBowlingChallenge(
    level: 8,
    firstThrow: BowlingHit.strike,
    secondThrow: BowlingHit.strike,
    thirdThrow: BowlingHit.strike,
    description: "Get a turkey (3 strikes).",
  ),
]);

extension ListTenthFrameBowlingChallegeX on List<TenthFrameBowlingChallenge> {
  TenthFrameBowlingChallenge? getByLevel(int lvl) =>
      tenthFrameBowlingChallenges.firstWhereOrNull((value) => value.level == lvl);
}

/// Evaluators are separate from the challenges to allow the challenge objects to serialize.
final bowlingChallengeEvaluators = List<ChallengeEvaluation>.unmodifiable(<ChallengeEvaluation>[
  ({required frame, strength}) => (frame.firstThrow ?? 0) >= 1,
  ({required frame, strength}) => (frame.firstThrow ?? 0) >= 1 && (frame.secondThrow ?? 0) >= 1,
  ({required frame, strength}) => (frame.firstThrow ?? 0) + (frame.secondThrow ?? 0) >= (strength ?? 10),
  ({required frame, strength}) => (frame.firstThrow ?? 0) >= (strength ?? 10),
  ({required frame, strength}) => (frame.firstThrow ?? 0) >= (strength ?? 10) && (frame.secondThrow ?? 0) >= 1,
  ({required frame, strength}) => frame.isSpare,
  ({required frame, strength}) => (frame.firstThrow ?? 0) >= (strength ?? 10) && frame.isSpare,
  ({required frame, strength}) => frame.isStrike,
]);

final tenthFrameBowlingChallengeEvaluators = List<ChallengeEvaluation>.unmodifiable(<ChallengeEvaluation>[
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return (frameTen.firstThrow ?? 0) >= 1 &&
        (frameTen.secondThrow ?? 0) >= 1 &&
        ((frameTen.thirdThrow ?? 0) >= 1 || !frameTen.hasThirdThrow);
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return (frameTen.firstThrow ?? 0) >= (strength ?? 10);
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return frameTen.hasSpare || frameTen.strikeCount >= 2;
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return (frameTen.firstThrow ?? 0) >= (strength ?? 10) &&
        (frameTen.hasSpare || frameTen.secondThrow == 10 || frameTen.thirdThrow == 10);
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return (frameTen.firstThrow ?? 0) >= (strength ?? 10) &&
        (frameTen.isSpare || frameTen.secondThrow == 10) &&
        (frameTen.thirdThrow ?? 0) >= (strength ?? 10);
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return frameTen.hasStrike;
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return frameTen.strikeCount >= 2;
  },
  ({required frame, strength}) {
    final frameTen = frame as TenthFrame;
    return frameTen.strikeCount == 3;
  },
]);
