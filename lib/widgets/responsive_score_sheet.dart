import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

import '../models/bowling_game.dart';
import '../models/frame.dart';
import '../utils/screen_utils.dart';
import '../utils/utils.dart';

/// A widget that displays a bowling game score sheet and automatically
/// adjusts its size and layout to fit the available width.
class ResponsiveScoreSheet extends StatelessWidget {
  final BowlingGame game;

  const ResponsiveScoreSheet({super.key, this.game = const BowlingGame()});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder provides the available width, making the widget responsive.
    return LayoutBuilder(
      builder: (context, constraints) {
        // The height and font sizes are calculated proportionally to the width,
        // ensuring the score sheet scales gracefully.
        final sheetHeight = constraints.maxWidth * 0.1;
        final baseFontSize = (constraints.maxWidth * 0.025).clamp(8.0, 14.0);

        return DefaultTextStyle(
          style: context.textStyles.bodySmall.copyWith(fontSize: baseFontSize),
          child: Container(
            height: sheetHeight + 20,
            decoration: BoxDecoration(
              color: Colors.black87,
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              // Using List.generate is a clean way to build the 10 frames.
              children: List.generate(10, (i) {
                final frameNum = i + 1;
                final isTenth = frameNum == 10;
                final result = i < game.results.length ? game.results[i] : null;

                return Flexible(
                  // The 10th frame is wider to accommodate a potential 3rd throw.
                  // The flex factor distributes space proportionally.
                  flex: isTenth ? 13 : 10,
                  child: _Frame(
                    frame: frameNum,
                    frameData: result?.frameData,
                    isSuccess: result?.isSuccess,
                    showBorder: i != 0,
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

/// A private widget representing a single frame in the score sheet.
class _Frame extends StatelessWidget {
  final int frame;
  final Frame? frameData;
  final bool? isSuccess;
  final bool showBorder;

  bool get isTenthFrame => frame == 10;

  const _Frame({
    required this.frame,
    this.frameData,
    this.isSuccess,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    String? firstThrow;
    String? secondThrow;
    String? thirdThrow;

    if (frameData != null) {
      firstThrow = frameData!.firstThrow.toThrowString();
      secondThrow = frameData!.isSpare ? '/' : frameData!.secondThrow.toThrowString();

      if (isTenthFrame) {
        final tenthFrame = frameData as TenthFrame;
        if (tenthFrame.hasThirdThrow) {
          thirdThrow = tenthFrame.isSpare2 ? '/' : tenthFrame.thirdThrow.toThrowString();
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Frame number header
        DecoratedBox(
          decoration: BoxDecoration(
            color: switch (isSuccess) {
              null => null,
              true => Colors.green.withOpacity(0.3),
              false => Colors.red.withOpacity(0.3),
            },
          ),
          child: Text(frame.toString(), textAlign: TextAlign.center),
        ),
        boxXS,
        // Main frame content (throws and score)
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: const BorderSide(color: Colors.grey),
                left: showBorder ? const BorderSide(color: Colors.grey, width: 2) : BorderSide.none,
              ),
            ),
            child: Column(
              children: [
                // Throws Row
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: _ThrowBox(showBorder: false, text: firstThrow)),
                      Expanded(child: _ThrowBox(text: secondThrow)),
                      if (isTenthFrame) Expanded(child: _ThrowBox(text: thirdThrow)),
                    ],
                  ),
                ),
                // Score
                Expanded(
                  child: Center(child: Text(frameData?.score?.toString() ?? '')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A private widget for a single throw box within a frame.
class _ThrowBox extends StatelessWidget {
  final bool showBorder;
  final String? text;

  const _ThrowBox({this.showBorder = true, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: showBorder ? const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))) : null,
      child: text != null ? Text(text!) : const SizedBox.shrink(),
    );
  }
}

extension on int? {
  String? toThrowString() {
    return switch (this) {
      null => null,
      0 => endash,
      10 => 'X',
      _ => toString(),
    };
  }
}