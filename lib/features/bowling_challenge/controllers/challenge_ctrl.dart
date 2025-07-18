import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/bowling_challenges.dart';
import '../../../models/frame.dart';
import 'challenge_state.dart';

part 'challenge_ctrl.g.dart';

@riverpod
class ChallengeCtrl extends _$ChallengeCtrl {
  @override
  ChallengeState build({
    int? id, // to differentiate challenges on 2-frame lairs
    required BowlingChallenge challenge,
    int? strength,
  }) {
    return ChallengeState(
      challenge: challenge,
      strength: strength,
      frame: challenge is TenthFrameBowlingChallenge
          ? const TenthFrame()
          : const Frame(),
    );
  }

  void updateThrow({required int ballThrow, required int value}) {
    ChallengeState newState = state;

    if (ballThrow == 1) {
      final frame = newState.frame.clearThrowsAfter(ballThrow);

      newState = newState.copyWith(
        frame: frame.copyWith(firstThrow: value),
      );
    }
    else if (ballThrow == 2) {
      final frame = newState.frame.clearThrowsAfter(ballThrow);

      newState = newState.copyWith(
        frame: frame.copyWith(
          secondThrow: value,
        ),
      );
    }
    else if (ballThrow == 3) {
      newState = newState.copyWith(
        frame: (newState.frame as TenthFrame).copyWith(
          thirdThrow: value,
        ),
      );
    }

    state = newState.copyWith(
      isSuccess: (!newState.isTenthFrame && newState.frame.isStrike) ||
          newState.challenge.evaluate(
            frame: newState.frame,
            strength: newState.strength,
          ),
    );
  }
}
