import 'package:dart_mappable/dart_mappable.dart';

import '../data/bowling_challenges.dart';
import 'frame.dart';

part 'challenge_result.mapper.dart';

@MappableClass()
abstract class ChallengeResultBase with ChallengeResultBaseMappable {
  final int game;
  final int frame;
  final int? strength;
  final Frame frameData;
  final bool isSuccess;

  const ChallengeResultBase({
    required this.game,
    required this.frame,
    this.strength,
    required this.frameData,
    this.isSuccess = false,
  });

  bool get isFailure => !isSuccess;
}

@MappableClass()
class ChallengeResult extends ChallengeResultBase with ChallengeResultMappable {
  final BowlingChallenge challenge;

  const ChallengeResult({
    required super.game,
    required super.frame,
    super.strength,
    required this.challenge,
    required super.frameData,
    super.isSuccess = false,
  });
}

@MappableClass()
class FinalChallengeResult extends ChallengeResultBase with FinalChallengeResultMappable {
  final TenthFrameBowlingChallenge challenge;

  const FinalChallengeResult({
    required super.game,
    required super.frame,
    super.strength,
    required this.challenge,
    required super.frameData,
    super.isSuccess = false,
  });
}
