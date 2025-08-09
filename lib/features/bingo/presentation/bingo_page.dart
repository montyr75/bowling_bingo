import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart' hide Space;
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../data/bonus.dart';
import '../../../models/bingo_card.dart';
import '../../../models/frame.dart';
import '../../../utils/popup_utils.dart';
import '../../../utils/screen_utils.dart';
import '../../../widgets/game_page_wrapper.dart';
import '../../../widgets/page_nav_button.dart';
import '../../../widgets/responsive_score_sheet.dart';
import '../../../models/bowling_game.dart';
import '../../app/services/app/app_service.dart';
import '../../bowling_challenge/presentation/challenge_display.dart';
import '../services/game_service.dart';
import '../services/game_state.dart';

class BingoPage extends StatelessWidget {
  const BingoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GamePageWrapper(
      bgImagePath: 'assets/images/boards.jpg',
      children: [
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(gameServiceProvider);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // state.currentGame != null
                //     ? ScoreSheet(
                //         game: state.currentGame!,
                //         sheetWidth: size.width * 0.9,
                //       )
                //     : ScoreSheet(sheetWidth: size.width * 0.9),
                ResponsiveScoreSheet(
                  game: state.currentGame ?? const BowlingGame(),
                ),
                boxL,
                SizedBox(
                  width: size.width * 0.94,
                  child: BingoCardDisplay(
                    card: state.card,
                    currentSpace: state.challenge?.space,
                  ),
                ),
                boxL,
                if (!state.hasChallenge) ...[
                  boxM,
                  PageNavButton(
                    label: !state.isGameOver ? 'Next Turn' : 'Next Game',
                    onPressed: () => !state.isGameOver
                        ? ref.read(gameServiceProvider.notifier).nextTurn()
                        : ref.read(gameServiceProvider.notifier).nextGame(),
                    // onPressed: () => _showBonus(),
                  ),
                ] else
                  ChallengeDisplay(
                    challenge: state.challenge!.challenge,
                    strength: state.challenge!.strength,
                    onSuccess: (frame) {
                      _onChallengeCompleted(
                        context: context,
                        ref: ref,
                        challenge: state.challenge!,
                        frameData: frame,
                        isSuccess: true,
                      );
                    },
                    onFailure: (frame) {
                      _onChallengeCompleted(
                        context: context,
                        ref: ref,
                        challenge: state.challenge!,
                        frameData: frame,
                        isSuccess: false,
                      );
                    },
                  ).animate().fadeIn(duration: 300.ms),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _onChallengeCompleted({
    required BuildContext context,
    required WidgetRef ref,
    required Challenge challenge,
    required Frame frameData,
    required bool isSuccess,
  }) async {
    final result = ref
        .read(gameServiceProvider.notifier)
        .onChallengeComplete(frameData: frameData, isSuccess: isSuccess);

    if (result.isBingo) {
      await _showBingo();
    } else if (result.bonus != null) {
      await _showBonus(result.bonus!);

      bool isBingo = false;

      switch (result.bonus) {
        case Bonus.freeSpace:
          isBingo = ref.read(gameServiceProvider.notifier).markRandomSpace();
          break;
        case Bonus.pointsMultiplier2:
          ref.read(gameServiceProvider.notifier).setPointsMultiplier(challenge.space, 2);
          break;
        case null:
          break;
      }

      if (isBingo && context.mounted) {
        await _showBingo();
      }
    }
  }

  Future<void> _showBingo() {
    return SmartDialog.show(
      builder: (context) {
        return GestureDetector(
          onTap: SmartDialog.dismiss,
          child: SizedBox(
            width: dialogMaxWidth,
            height: 233,
            child: Stack(
              children: [
                Image.asset('assets/images/bingo.png', width: dialogMaxWidth),
                Align(
                  alignment: const Alignment(0, 0.4),
                  child: Text(
                    '(tap to dismiss)',
                    style: context.textStyles.titleMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ).animate().scale(delay: const Duration(seconds: 1)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showBonus(Bonus bonus) {
    return SmartDialog.show(
      builder: (context) {
        return GestureDetector(
          onTap: SmartDialog.dismiss,
          child: SizedBox(
            width: dialogMaxWidth,
            height: 233,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(lg),
                  child: Image.asset('assets/images/bonus.png', width: dialogMaxWidth),
                ),
                Align(
                  alignment: const Alignment(0, 0.2),
                  child: Text(
                    bonus.message,
                    style: context.textStyles.bodyLarge.copyWith(color: Colors.black),
                  ).animate().fadeIn(),
                ),
                Align(
                  alignment: const Alignment(0, 0.65),
                  child: Text(
                    '(tap to dismiss)',
                    style: context.textStyles.titleMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ).animate().scale(delay: const Duration(seconds: 1)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BingoCardDisplay extends StatelessWidget {
  final BingoCard card;
  final int? currentSpace;

  const BingoCardDisplay({super.key, required this.card, this.currentSpace});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: card.spaces.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: card.extent),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return BingoSpaceDisplay(
          space: card[index],
          isSelected: currentSpace == index,
        );
      },
    );
  }
}

class BingoSpaceDisplay extends ConsumerWidget {
  final Space space;
  final bool isSelected;
  final Widget? child;

  const BingoSpaceDisplay({
    super.key,
    required this.space,
    this.isSelected = false,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marker = ref.read(appServiceProvider).bingoMarker;

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isSelected
              ? const AssetImage('assets/images/green_square.png')
              : const AssetImage('assets/images/grey_square.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: switch (space.state) {
              SpaceState.unmarked => const [],
              SpaceState.bonus => [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.yellowAccent, BlendMode.srcATop),
                  child: Center(
                    child: Image.asset(
                      'assets/images/question_mark.png',
                      width: constraints.maxWidth * 0.35,
                    ).animate().scale(),
                  ),
                ),
              ],
              SpaceState.marked => [
                Image.asset(marker.assetPath).animate().scale(),
                Center(
                  child: Text(
                    space.points.toString(),
                    style: context.textStyles.displaySmall.copyWith(fontSize: constraints.maxWidth * 0.2),
                  ).animate().scale(),
                ),
                if (space.hasPointsMultiplier)
                  TopRight(
                    child: Text(
                      'x${space.pointsMultiplier}',
                      style: context.textStyles.displaySmall.copyWith(
                        fontSize: constraints.maxWidth * 0.2,
                        color: Colors.yellowAccent,
                      ),
                    ).animate().scale(delay: const Duration(milliseconds: 300)),
                  ),
              ],
            },
          );
        },
      ),
    );
  }
}
