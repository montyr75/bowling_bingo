import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/frame.dart';
import '../../../utils/popup_utils.dart';
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
                  ),
                ] else
                  ChallengeDisplay(
                    challenge: state.challenge!.challenge,
                    strength: state.challenge!.strength,
                    onSuccess: (frame) {
                      _onChallengeCompleted(context: context, ref: ref, frameData: frame, isSuccess: true);
                    },
                    onFailure: (frame) {
                      _onChallengeCompleted(context: context, ref: ref, frameData: frame, isSuccess: false);
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
    required Frame frameData,
    required bool isSuccess,
  }) async {
    final result = ref
        .read(gameServiceProvider.notifier)
        .onChallengeComplete(frameData: frameData, isSuccess: isSuccess);

    if (result.isBingo) {
      await showInfoDialog(context: context, title: "BINGO!", message: "You win!");
    } else if (result.isBonus) {
      await showInfoDialog(context: context, title: "BONUS!", message: "Enjoy your free bonus space!");

      final isBingo = ref.read(gameServiceProvider.notifier).markRandomSpace();

      if (isBingo && context.mounted) {
        await showInfoDialog(context: context, title: "BINGO!", message: "You win!");
      }
    }
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

    Widget content = child ?? const Text(' ');

    if (space.isMarked) {
      content = Image.asset(marker.assetPath, fit: BoxFit.contain).animate().scale();
    } else if (space.isBonus) {
      content = ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.yellowAccent, BlendMode.srcATop),
        child: Image.asset('assets/images/question_mark.png', fit: BoxFit.contain).animate().scale(),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isSelected
              ? const AssetImage('assets/images/green_square.png')
              : const AssetImage('assets/images/square.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: content,
        ),
      ),
    );
  }
}
