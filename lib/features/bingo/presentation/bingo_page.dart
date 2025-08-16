import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../data/mystery.dart';
import '../../../models/bingo_card.dart';
import '../../../models/frame.dart';
import '../../../utils/popup_utils.dart';
import '../../../utils/screen_utils.dart';
import '../../../utils/utils.dart';
import '../../../widgets/bowling_score_sheet.dart';
import '../../../widgets/game_bar.dart';
import '../../../widgets/page_nav_button.dart';
import '../../../widgets/stats_page.dart';
import '../../app/services/app/app_service.dart';
import '../../bowling_challenge/presentation/challenge_display.dart';
import '../services/game_service.dart';
import '../services/game_state.dart';

class BingoPage extends StatefulWidget {
  const BingoPage({super.key});

  @override
  State<BingoPage> createState() => _BingoPageState();
}

class _BingoPageState extends State<BingoPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      child: BackdropScaffold(
        appBar: buildGameBar(),
        maintainBackLayerState: false,
        backLayerBackgroundColor: Colors.black,
        backLayer: const StatsPage(),
        frontLayer: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/boards.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: paddingAllM,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final state = ref.watch(gameServiceProvider);

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.93,
                                      child: BowlingScoreSheet(game: state.currentGame),
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
                                        onPressed: () {
                                          !state.isGameOver
                                              ? ref.read(gameServiceProvider.notifier).nextTurn()
                                              : ref.read(gameServiceProvider.notifier).nextGame();

                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            _scrollController.animateTo(
                                              _scrollController.position.maxScrollExtent,
                                              duration: 300.ms,
                                              curve: Curves.easeOut,
                                            );
                                          });
                                        },
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
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onChallengeCompleted({
    required BuildContext context,
    required WidgetRef ref,
    required Challenge challenge,
    required Frame frameData,
    required bool isSuccess,
  }) async {
    final gameService = ref.read(gameServiceProvider.notifier);

    final mystery = gameService.onChallengeComplete(frameData: frameData, isSuccess: isSuccess);

    if (mystery != null) {
      await _showMystery(mystery);

      switch (mystery) {
        case Mystery.freeSpace:
          gameService.markRandomSpace();
          break;
        case Mystery.pointsMultiplier2:
          gameService.setPointsMultiplier(challenge.space, 2);
          break;
        case Mystery.pointsMultiplierNegative:
          gameService.setPointsMultiplier(challenge.space, -1);
          break;
        case Mystery.loseSpace:
          gameService.unmarkRandomSpace();
          break;
      }

      gameService.setRandomMysterySpace();
    }

    await Future.delayed(const Duration(seconds: 1));

    if (ref.read(gameServiceProvider).card.isBingo) {
      _showBingo();
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
                    style: context.textTheme.titleMedium?.copyWith(color: Colors.black),
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

  Future<void> _showMystery(Mystery mystery) {
    return SmartDialog.show(
      builder: (context) {
        final imagePath = mystery.isBonus ? 'assets/images/bonus.png' : 'assets/images/penalty.png';

        final textTheme = context.textTheme;

        return GestureDetector(
          onTap: SmartDialog.dismiss,
          child: SizedBox(
            width: dialogMaxWidth,
            height: 233,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(lg),
                  child: Image.asset(imagePath, width: dialogMaxWidth),
                ),
                Align(
                  alignment: Alignment(0, mystery.isBonus ? 0.2 : 0.54),
                  child: Text(
                    mystery.message,
                    style: textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ).animate().fadeIn(),
                ),
                Align(
                  alignment: Alignment(0, mystery.isBonus ? 0.65 : 0.77),
                  child: Text(
                    '(tap to dismiss)',
                    style: textTheme.titleMedium?.copyWith(color: Colors.black),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            children: [
              Image.asset(
                marker.assetPath,
              ).animate(target: space.state == SpaceState.marked ? 1 : 0).scale(duration: 200.ms),
              if (space.state == SpaceState.mystery)
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.yellowAccent, BlendMode.srcATop),
                  child: Center(
                    child: Image.asset(
                      'assets/images/question_mark.png',
                      width: constraints.maxWidth * 0.35,
                    ).animate().scale(),
                  ),
                )
              else if (space.state == SpaceState.marked) ...[
                Center(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: paddingAllM,
                      child: Text(
                        space.points.toString(),
                        style: context.textTheme.displaySmall?.copyWith(
                          fontSize: constraints.maxWidth * 0.16,
                          color: !space.hasPointsMultiplier
                              ? Colors.white
                              : space.pointsMultiplier > 1
                              ? Colors.yellowAccent
                              : Colors.red,
                        ),
                      ).animate().scale(),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
