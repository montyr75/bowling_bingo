import 'package:dart_mappable/dart_mappable.dart';
import 'package:recase/recase.dart';

import '../utils/roll_table.dart';

part 'bowler_levels.mapper.dart';

@MappableEnum()
enum BowlerLevel {
  novice(
    minAvg: 0,
    maxAvg: 99,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 10): 1,
      RollRange(11, 25): 2,
      RollRange(26, 47): 3,
      RollRange(48, 69): 4,
      RollRange(70, 84): 5,
      RollRange(85, 94): 6,
      RollRange(95, 99): 7,
      RollRange(100, 100): 8,
    }),
  ),
  beginner(
    minAvg: 100,
    maxAvg: 124,
    challengeMod: 1,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 2): 1,
      RollRange(3, 11): 2,
      RollRange(12, 26): 3,
      RollRange(27, 48): 4,
      RollRange(49, 70): 5,
      RollRange(71, 85): 6,
      RollRange(86, 95): 7,
      RollRange(96, 100): 8,
    }),
  ),
  intermediate(
    minAvg: 125,
    maxAvg: 149,
    challengeMod: 1,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 6): 2,
      RollRange(7, 16): 3,
      RollRange(17, 31): 4,
      RollRange(32, 53): 5,
      RollRange(54, 75): 6,
      RollRange(76, 90): 7,
      RollRange(91, 100): 8,
    }),
  ),
  proficient(
    minAvg: 150,
    maxAvg: 174,
    challengeMod: 2,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 11): 3,
      RollRange(12, 26): 4,
      RollRange(27, 41): 5,
      RollRange(42, 63): 6,
      RollRange(64, 85): 7,
      RollRange(86, 100): 8,
    }),
  ),
  advanced(
    minAvg: 175,
    maxAvg: 199,
    challengeMod: 2,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 12): 4,
      RollRange(13, 27): 5,
      RollRange(28, 52): 6,
      RollRange(53, 77): 7,
      RollRange(78, 100): 8,
    }),
  ),
  pro(
    minAvg: 200,
    maxAvg: 300,
    challengeMod: 3,
    maxChallengeLevelTable: RollTable<int>({
      RollRange(1, 17): 5,
      RollRange(18, 42): 6,
      RollRange(43, 70): 7,
      RollRange(71, 100): 8,
    }),
  );

  final int minAvg;
  final int maxAvg;
  final int challengeMod;
  final RollTable<int> maxChallengeLevelTable;

  const BowlerLevel({
    required this.minAvg,
    required this.maxAvg,
    this.challengeMod = 0,
    required this.maxChallengeLevelTable,
  });

  @override
  String toString() => ReCase(name).titleCase;

  String toRange() => switch (this) {
    BowlerLevel.novice => "up to $maxAvg",
    BowlerLevel.pro => "$minAvg+",
    _ => "$minAvg-$maxAvg",
  };
}

final bowlerLevelTable = RollTable<BowlerLevel>({
  RollRange(BowlerLevel.novice.minAvg, BowlerLevel.novice.maxAvg): BowlerLevel.novice,
  RollRange(BowlerLevel.beginner.minAvg, BowlerLevel.beginner.maxAvg): BowlerLevel.beginner,
  RollRange(BowlerLevel.intermediate.minAvg, BowlerLevel.intermediate.maxAvg): BowlerLevel.intermediate,
  RollRange(BowlerLevel.proficient.minAvg, BowlerLevel.proficient.maxAvg): BowlerLevel.proficient,
  RollRange(BowlerLevel.advanced.minAvg, BowlerLevel.advanced.maxAvg): BowlerLevel.advanced,
  RollRange(BowlerLevel.pro.minAvg, BowlerLevel.pro.maxAvg): BowlerLevel.pro,
});