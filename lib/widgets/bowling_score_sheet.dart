import 'package:flutter/material.dart';

import '../models/bowling_game.dart';
import '../models/challenge_result.dart';
import '../models/frame.dart';
import '../utils/utils.dart';
import 'frame_editor.dart';

class BowlingScoreSheet extends StatelessWidget {
  final BowlingGame? game;

  const BowlingScoreSheet({super.key, this.game});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final List<ChallengeResultBase?> data = List.filled(10, null);

    if (game != null) {
      for (int i = 0; i < game!.results.length; i++) {
        data[i] = game!.results[i];
      }
    }

    return DefaultTextStyle(
      style: textTheme.bodyMedium!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Row for the frame numbers
            Row(
              children: List.generate(
                10,
                (index) => Expanded(
                  flex: index == 9 ? 2 : 1, // 10th frame is wider
                  child: FrameHeader(
                    frameNumber: index + 1,
                    result: data[index],
                  ),
                ),
              ),
            ),
            const Divider(height: 3, color: Colors.grey),
            // Row for the individual frame throws
            Row(
              children: List.generate(
                10,
                (index) => Expanded(
                  flex: index == 9 ? 2 : 1,
                  child: FrameThrows(
                    result: data[index],
                    isTenthFrame: index == 9,
                    isFirstFrame: index == 0,
                  ),
                ),
              ),
            ),
            // Row for the cumulative scores
            Row(
              children: List.generate(
                10,
                (index) => Expanded(
                  flex: index == 9 ? 2 : 1,
                  child: FrameScoreDisplay(
                    result: data[index],
                    isFirstFrame: index == 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FrameHeader extends StatelessWidget {
  final int frameNumber;
  final ChallengeResultBase? result;

  const FrameHeader({super.key, required this.frameNumber, this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: switch (result?.isSuccess) {
          true => Colors.green.withValues(alpha: 0.3),
          false => Colors.red.withValues(alpha: 0.3),
          null => null,
        },
      ),
      child: Text(
        frameNumber.toString(),
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}

class FrameThrows extends StatelessWidget {
  final ChallengeResultBase? result;
  final bool isTenthFrame;
  final bool isFirstFrame;

  const FrameThrows({
    super.key,
    this.result,
    this.isTenthFrame = false,
    this.isFirstFrame = false,
  });

  @override
  Widget build(BuildContext context) {
    final frameData = result?.frameData;

    String? firstThrow;
    String? secondThrow;
    String? thirdThrow;
    TenthFrame? tenthFrame;

    if (frameData != null) {
      if (isTenthFrame) {
        tenthFrame = frameData as TenthFrame;
      }

      firstThrow = frameData.firstThrow.toThrowString();
      secondThrow = frameData.isSpare ? '/' : frameData.secondThrow.toThrowString();

      if (isTenthFrame && tenthFrame!.hasThirdThrow) {
        thirdThrow = tenthFrame.isSpare2 ? '/' : tenthFrame.thirdThrow.toThrowString();
      }
    }

    // The 10th frame has a different layout with 3 possible rolls.
    if (isTenthFrame) {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        child: Row(
          children: [
            _buildThrowBox(firstThrow, isLastRoll: false, isTenth: true),
            _buildThrowBox(secondThrow, isLastRoll: false, isTenth: true),
            _buildThrowBox(thirdThrow, isLastRoll: true, isTenth: true),
          ],
        ),
      );
    }

    // Standard frames (1-9) have a single row for the two rolls.
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: isFirstFrame ? BorderSide.none : const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Row(
        children: [
          _buildThrowBox(firstThrow, isLastRoll: false),
          _buildThrowBox(secondThrow, isLastRoll: true),
        ],
      ),
    );
  }

  // Helper method to build a single roll box with appropriate text.
  Widget _buildThrowBox(String? text, {required bool isLastRoll, bool isTenth = false}) {
    return Expanded(
      child: Container(
        height: 20,
        decoration: BoxDecoration(
          border: isLastRoll
              ? null
              : const Border(
                  right: BorderSide(color: Colors.grey, width: 1),
                ),
        ),
        alignment: Alignment.center,
        child: Text(text ?? ''),
      ),
    );
  }
}

class FrameScoreDisplay extends StatelessWidget {
  final ChallengeResultBase? result;
  final bool isFirstFrame;

  const FrameScoreDisplay({super.key, this.result, this.isFirstFrame = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: isFirstFrame ? BorderSide.none : const BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Text(result?.frameData.score?.toString() ?? ''),
    );
  }
}
