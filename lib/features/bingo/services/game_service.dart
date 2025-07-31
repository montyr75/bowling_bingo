import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/bonus.dart';
import '../../../data/bowling_challenges.dart';
import '../../../models/bowling_game.dart';
import '../../../models/challenge_result.dart';
import '../../../models/frame.dart';
import '../../../utils/roller.dart';
import '../../../utils/utils.dart';
import '../../app/services/app/app_service.dart';
import 'game_state.dart';

part 'game_service.g.dart';

@riverpod
class GameService extends _$GameService {
  @override
  GameState build() {
    // final appState = ref.read(appServiceProvider);

    return const GameState().init();
  }

  void restore(GameState value) {
    state = value;
  }

  void nextTurn() {
    final availableSpaces = state.card.getUnmarkedSpaces().toList()..shuffle();
    final bowlerLevel = ref.read(appServiceProvider).bowlerLevel;

    late final int lvl;
    late final int str;
    late final BowlingChallenge challenge;

    if (state.frame < 10) {
      lvl = bowlerLevel.maxChallengeLevelTable.lookup(roll(100))!;
      str = (rollDice(1, lvl, 2) + bowlerLevel.challengeMod).maxOf(10);

      challenge = BowlingChallenge.generateBowlingChallenge(
        level: lvl,
        mod: bowlerLevel.challengeMod,
        strength: str,
      );
    } else {
      lvl = bowlerLevel.maxChallengeLevelTable.lookup(roll(100))!.minOf(4);
      str = (rollDice(1, lvl, 3) + bowlerLevel.challengeMod).maxOf(10);

      challenge = TenthFrameBowlingChallenge.generateBowlingChallenge(
        level: lvl,
        mod: bowlerLevel.challengeMod,
        strength: str,
      );
    }

    state = state.copyWith(
      challenge: Challenge(
        space: availableSpaces.first.index,
        challenge: challenge,
        strength: str,
      ),
    );
  }

  ({bool isBingo, Bonus? bonus}) onChallengeComplete({required Frame frameData, required bool isSuccess}) {
    GameState newState = _updateHistory(
      state,
      ChallengeResult(
        game: state.game,
        frame: state.frame,
        strength: state.challenge!.strength,
        challenge: state.challenge!.challenge,
        frameData: frameData,
        isSuccess: isSuccess,
      ),
    );

    final space = state.card[state.challenge!.space];

    if (isSuccess) {
      newState = newState.copyWith(
        card: state.card.markSpace(space.index),
      );
    }

    if (state.frame < 10) {
      newState = _nextFrame(newState);
    }

    state = newState.clearChallenge();

    return (
      isBingo: state.card.isBingo,
      bonus: space.isBonus && isSuccess ? Bonus.getRandomBonus() : null,
    );
  }

  bool markRandomSpace() {
    final card = state.card.markRandomSpace();

    state = state.copyWith(
      card: card,
    );

    return state.card.isBingo;
  }

  void setPointsMultiplier(int index, int multiplier) {
    final card = state.card.setSpacePointsMultiplier(index, multiplier);

    state = state.copyWith(
      card: card,
    );
  }

  void clearBingoCard() {
    state = state.init(extent: state.card.extent);
  }

  void nextGame() {
    final history = state.history.toMap();
    history[state.game + 1] = const BowlingGame();

    state = state.copyWith(
      game: state.game + 1,
      frame: 1,
      history: Map.unmodifiable(history),
    );

    nextTurn();
  }

  GameState _nextFrame(GameState state) {
    return state.copyWith(
      frame: state.frame + 1,
    );
  }

  GameState _updateHistory(GameState state, ChallengeResultBase challengeResult) {
    final history = state.history.toMap();
    history[state.game] = history[state.game]!.add(challengeResult);

    return state.copyWith(
      history: Map<int, BowlingGame>.unmodifiable(history),
    );
  }

  // void _saveState() {
  //   ref.read(appServiceProvider.notifier).saveState();
  // }
}

extension BowlingGamesX on Map<int, BowlingGame> {
  int get seriesTotal {
    return <int>[
      for (final game in values) game.score,
    ].sum();
  }
}
