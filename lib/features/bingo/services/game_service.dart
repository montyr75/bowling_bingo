import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/bonus.dart';
import '../../../data/bowling_challenges.dart';
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

    return const GameState().initialize5By5();
  }

  void restore(GameState value) {
    state = value;
  }

  void nextTurn() {
    final availableSpaces = state.card.where((space) => !space.isMarked).toList()..shuffle();
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
      final card = state.card.markSpace(space.index);

      newState = newState.copyWith(
        card: card,
        points: card.calculateScore(extent: 5),
      );
    }

    state = _nextFrame(newState).clearChallenge();

    return (
      isBingo: state.card.isBingo(bingoWinConditions5x5),
      bonus: space.isBonus ? Bonus.getRandomBonus() : null,
    );
  }

  bool markRandomSpace() {
    final card = state.card.markRandomSpace();

    state = state.copyWith(
      card: card,
      points: card.calculateScore(extent: 5),
    );

    return state.card.isBingo(bingoWinConditions5x5);
  }

  void setPointsMultiplier(int index, int multiplier) {
    final card = state.card.setSpacePointsMultiplier(index, multiplier);

    state = state.copyWith(
      card: card,
      points: card.calculateScore(extent: 5),
    );
  }

  void clearBingoCard() {
    state = state.initialize5By5();
  }

  GameState _nextFrame(GameState state) {
    final isNewGame = state.frame == 10;

    return state.copyWith(
      game: isNewGame ? state.game + 1 : null,
      frame: !isNewGame ? state.frame + 1 : 1,
    );
  }

  GameState _updateHistory(GameState state, ChallengeResultBase challengeResult) {
    final history = state.history.toMap();
    history[state.game] = _scoreGame((history[state.game]?.toList() ?? <ChallengeResultBase>[])..add(challengeResult));

    return state.copyWith(
      history: Map<int, List<ChallengeResultBase>>.unmodifiable(history),
    );
  }

  List<ChallengeResultBase> _scoreGame(List<ChallengeResultBase> game) {
    int score = 0;

    final frames = game.map((result) => result.frameData).toList();

    return game.map((result) {
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

  // void _saveState() {
  //   ref.read(appServiceProvider.notifier).saveState();
  // }
}

extension BowlingGamesX on Map<int, List<ChallengeResultBase>> {
  int get totalWon {
    int total = 0;

    for (final game in values) {
      total += game.count((value) => value.isSuccess);
    }

    return total;
  }

  int get totalChallenges {
    int total = 0;

    for (final game in values) {
      total += game.length;
    }

    return total;
  }

  int get percentSuccess {
    final totalChallenges = this.totalChallenges;
    final totalWon = this.totalWon;

    if (totalChallenges == 0 || totalWon == 0) {
      return 0;
    }

    return (totalWon / totalChallenges * 100).round();
  }

  int get percentFailure {
    if (totalChallenges == 0) {
      return 0;
    }

    return 100 - percentSuccess;
  }
}
