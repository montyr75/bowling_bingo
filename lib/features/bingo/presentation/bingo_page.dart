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
import '../../bowling_challenge/presentation/challenge_display.dart';
import '../services/game_service.dart';
import '../services/game_state.dart';

class BingoPage extends ConsumerWidget {
  const BingoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameServiceProvider);
    final size = MediaQuery.of(context).size;

    return GamePageWrapper(
      bgImagePath: 'assets/images/boards.jpg',
      children: [
        for (int i = 0; i < state.history.values.length; i++) ...[
          ScoreSheet(results: state.history.values.elementAt(i)),
          boxL,
        ],
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
            label: !state.isTenthFrame ? 'Next Turn' : 'Next Game',
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
  }

  Future<void> _onChallengeCompleted({
    required BuildContext context,
    required WidgetRef ref,
    required Frame frameData,
    required bool isSuccess,
  }) async {
    final isBingo = ref
        .read(gameServiceProvider.notifier)
        .onChallengeComplete(frameData: frameData, isSuccess: isSuccess);

    if (isBingo) {
      await showInfoDialog(context: context, title: "BINGO!", message: "You win!");
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

class BingoSpace extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isSelected ? const AssetImage('assets/images/green_square.png') : const AssetImage('assets/images/square.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: FittedBox(
        child: space.isMarked ? Image.asset('assets/images/ball.png', fit: BoxFit.contain) : const Text(' '),
      ),
    );
  }
}
