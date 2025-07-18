import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/bowling_challenges.dart';
import '../../../models/frame.dart';
import '../../../utils/popup_utils.dart';
import '../../../utils/screen_utils.dart';
import '../../../widgets/frame_editor.dart';
import '../controllers/challenge_ctrl.dart';

class ChallengeDisplay extends ConsumerWidget {
  static const frameWidth = 125.0;
  static const frameHeight = 75.0;
  static const maxWidth = 350.0;

  final int? challengeID;
  final BowlingChallenge challenge;
  final int? strength;
  final bool showButtons;
  final ValueChanged<Frame> onSuccess;
  final ValueChanged<Frame> onFailure;

  const ChallengeDisplay({
    super.key,
    this.challengeID,
    required this.challenge,
    this.strength,
    this.showButtons = true,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      challengeCtrlProvider(
        id: challengeID,
        challenge: challenge,
        strength: strength,
      ),
    );

    final ctrl = ref.read(
      challengeCtrlProvider(
        id: challengeID,
        challenge: challenge,
        strength: strength,
      ).notifier,
    );

    final styles = context.textStyles;

    String? thirdThrow;

    if (state.isTenthFrame) {
      final tenthChallenge = challenge as TenthFrameBowlingChallenge;

      thirdThrow = switch (tenthChallenge.thirdThrow) {
        null => null,
        _ => tenthChallenge.thirdThrow!.toDisplay(strength),
      };
    }

    String? secondThrow = switch (challenge.secondThrow) {
      null => null,
      _ => challenge.secondThrow!.toDisplay(),
    };

    String? firstThrow;

    if (challenge.firstThrow != null) {
      switch (challenge.firstThrow!) {
        case BowlingHit.min1:
        case BowlingHit.min:
          firstThrow = challenge.firstThrow!.toDisplay(strength);
          break;
        case BowlingHit.strike:
          if (!state.isTenthFrame) {
            secondThrow = challenge.firstThrow!.toDisplay();
          } else {
            firstThrow = challenge.firstThrow!.toDisplay(strength);
          }
          break;
        default:
          break;
      }
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.black54,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(med),
                topRight: Radius.circular(med),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      width: frameWidth,
                      height: frameHeight,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (firstThrow != null)
                                  Container(
                                    width: frameWidth * .3,
                                    height: double.infinity,
                                    padding: paddingAllS,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(firstThrow),
                                    ),
                                  ),
                                Container(
                                  width: frameWidth * .33,
                                  height: double.infinity,
                                  padding: paddingAllS,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: secondThrow != null
                                      ? FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(secondThrow),
                                        )
                                      : noWidget,
                                ),
                                if (state.isTenthFrame)
                                  Container(
                                    width: frameWidth * .33,
                                    height: double.infinity,
                                    padding: paddingAllS,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: thirdThrow != null
                                        ? FittedBox(
                                            fit: BoxFit.fill,
                                            child: Text(thirdThrow),
                                          )
                                        : noWidget,
                                  ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (challenge.frameTotal != null)
                                  SizedBox(
                                    width: frameWidth * .33,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Text(
                                        challenge.frameTotal!.toDisplay(strength),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: frameHeight,
                        padding: paddingAllM,
                        child: Text(
                          challenge.toDisplay(strength),
                          style: styles.bodyMedium.copyWith(height: 1.2),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: sm),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: sm),
                    child: state.isTenthFrame
                        ? const Text(
                            "* For any throw with a requirement, a strike succeeds.",
                            style: TextStyle(fontSize: 10),
                          )
                        : const Text(
                            "* A strike always succeeds.",
                            style: TextStyle(fontSize: 10),
                          ),
                  ),
                ),
              ],
            ),
          ),
          boxM,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showButtons)
                FrameEditor(
                  frame: state.frame,
                  isTenthFrame: state.isTenthFrame,
                  onSelected: showButtons
                      ? (ballThrow, value) {
                          ctrl.updateThrow(
                            ballThrow: ballThrow,
                            value: value,
                          );
                        }
                      : null,
                ),
              if (showButtons && state.frame.isComplete) ...[
                if (!state.isSuccess)
                  ElevatedButton(
                    onPressed: () {
                      showConfirmDialog(
                        context: context,
                        title: "Failure!",
                        message: "You have failed! Better luck next time.",
                        yesMsg: "Confirm Failure",
                        noMsg: "Cancel",
                        onConfirm: () => onFailure(state.frame),
                      );
                    },
                    child: const Text('Failure'),
                  ).animate().slideX()
                else
                  ElevatedButton(
                    onPressed: () {
                      showConfirmDialog(
                        autoDismiss: true,
                        context: context,
                        title: "Success!",
                        message: "You've bested the challenge!",
                        yesMsg: "Confirm Success",
                        noMsg: "Cancel",
                        onConfirm: () => onSuccess(state.frame),
                      );
                    },
                    child: const Text('Success'),
                  ).animate().slideX(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
