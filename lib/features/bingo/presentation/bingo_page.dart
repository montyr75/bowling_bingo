import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart' hide Space;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../data/bonus.dart';
import '../../../models/frame.dart';
import '../../../utils/screen_utils.dart';
import '../../../widgets/game_page_wrapper.dart';
import '../../../widgets/grid_layout.dart';
import '../../../widgets/page_nav_button.dart';
import '../../../widgets/score_sheet.dart';
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
            final history = ref.watch(gameServiceProvider.select((state) => state.history));

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < history.values.length; i++) ...[
                  ScoreSheet(results: history.values.elementAt(i)).animate().slideY(),
                  boxL,
                ],
              ],
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(gameServiceProvider);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.4,
                  child: BingoCard(
                    card: state.card,
                    currentSpace: state.challenge?.space,
                  ),
                ),
                boxM,
                if (!state.hasChallenge) ...[
                  boxM,
                  PageNavButton(
                    label: !state.isNewGame ? 'Next Turn' : 'Next Game',
                    onPressed: () => ref.read(gameServiceProvider.notifier).nextTurn(),
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
            width: 400,
            height: 267,
            child: Stack(
              children: [
                Image.asset('assets/images/bingo.png', width: 400),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 75,
                  child: Text(
                    '(tap to dismiss)',
                    style: context.textStyles.titleMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ).animate().scale(delay: const Duration(seconds: 2)),
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
            width: 400,
            height: 267,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(lg),
                  child: Image.asset('assets/images/bonus.png', width: 400),
                ),
                Positioned(
                  left: 95,
                  right: 95,
                  bottom: 80,
                  child: Text(
                    bonus.message,
                    style: context.textStyles.bodyLarge.copyWith(color: Colors.black),
                  ).animate().fadeIn(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 40,
                  child: Text(
                    '(tap to dismiss)',
                    style: context.textStyles.titleMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ).animate().scale(delay: const Duration(seconds: 2)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BingoCard extends StatelessWidget {
  final List<Space> card;
  final int? currentSpace;

  const BingoCard({super.key, required this.card, this.currentSpace});

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      children: card.map((space) {
        return BingoSpace(
          space: space,
          isSelected: currentSpace == space.index,
        );
      }).toList(),
    );
  }
}

class BingoSpace extends ConsumerWidget {
  final Space space;
  final bool isSelected;
  final Widget? child;

  const BingoSpace({
    super.key,
    required this.space,
    this.isSelected = false,
    this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marker = ref.read(appServiceProvider).bingoMarker;

    List<Widget> content = [child ?? const Text(' ')];

    if (space.isMarked) {
      if (space.hasPointsMultiplier) {
        content = [
          Image.asset(marker.assetPath).animate().scale(),
          Image.asset('assets/images/star.png'),
        ];
      } else {
        content = [Image.asset(marker.assetPath).animate().scale()];
      }
    } else if (space.isBonus) {
      content = [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.yellowAccent, BlendMode.srcATop),
            child: Image.asset('assets/images/question_mark.png').animate().scale(),
          ),
        ),
      ];
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isSelected
              ? const AssetImage('assets/images/green_square.png')
              : const AssetImage('assets/images/grey_square.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Stack(
          children: content,
        ),
      ),
    );
  }
}
