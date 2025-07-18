import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/frame.dart';
import '../../../utils/popup_utils.dart';
import '../../../utils/screen_utils.dart';
import '../../../widgets/game_page_wrapper.dart';
import '../../../widgets/grid_layout.dart';
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
      showBowlingTip: true,
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
          ElevatedButton(
            onPressed: () => ref.read(gameServiceProvider.notifier).nextTurn(),
            child: const Text('Next Turn', style: TextStyle(fontSize: 18)),
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
          ).animate().scale(duration: 200.ms),
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
    return Card(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          border: isSelected ? Border.all(color: Colors.yellow, width: 3) : null,
          image: space.isMarked
              ? const DecorationImage(
                  image: AssetImage('assets/images/ball.png'),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: const FittedBox(
          child: Text(' '),
        ),
      ),
    );
  }
}
