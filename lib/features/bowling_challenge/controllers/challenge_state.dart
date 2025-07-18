import '../../../data/bowling_challenges.dart';
import '../../../models/frame.dart';

class ChallengeState {
  final BowlingChallenge challenge;
  final int? strength;
  final Frame frame;
  final bool isSuccess;

  const ChallengeState({
    required this.challenge,
    this.strength,
    this.frame = const Frame(),
    this.isSuccess = false,
  });

  ChallengeState copyWith({
    BowlingChallenge? challenge,
    int? strength,
    Frame? frame,
    bool? isSuccess,
  }) {
    return ChallengeState(
      challenge: challenge ?? this.challenge,
      strength: strength ?? this.strength,
      frame: frame ?? this.frame,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  bool get isTenthFrame => challenge is TenthFrameBowlingChallenge || frame is TenthFrame;
}