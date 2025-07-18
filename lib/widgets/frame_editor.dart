import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';

import '../models/frame.dart';
import '../utils/utils.dart';

typedef ScoreOptionSelected = void Function(int ballThrow, int value);

class FrameEditor extends StatelessWidget {
  static const options = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    endash,
    "/",
    "X",
  ];

  final Frame frame;
  final bool isTenthFrame;
  final ScoreOptionSelected? onSelected;

  bool get enabled => onSelected != null;

  const FrameEditor({
    super.key,
    required this.frame,
    this.isTenthFrame = false,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    String? firstThrow;
    String? secondThrow;
    String? thirdThrow;
    TenthFrame? tenthFrame;

    final numberStyle = context.textStyles.bodyLarge;

    if (isTenthFrame) {
      tenthFrame = frame as TenthFrame;
    }

    final currentThrow = frame.currentThrow;

    if (currentThrow == null) {
      firstThrow = frame.firstThrow.toThrowString();
      secondThrow = frame.isSpare ? '/' : frame.secondThrow.toThrowString();

      if (isTenthFrame && tenthFrame!.hasThirdThrow) {
        thirdThrow = tenthFrame.isSpare2 ? '/' : tenthFrame.thirdThrow.toThrowString();
      }
    }
    else if (currentThrow == 2) {
      firstThrow = frame.firstThrow.toThrowString();
    }
    else if (currentThrow == 3) {
      firstThrow = frame.isStrike ? 'X' : frame.firstThrow.toThrowString();

      if (frame.isSpare) {
        secondThrow = '/';
      }
      else {
        secondThrow = frame.secondThrow.toThrowString();
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(5),
        color: Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ThrowBox(
            child: TextButton(
              onPressed: enabled ? () => _showSelectionPopup(
                context: context,
                ballThrow: 1,
                options: _filterOptions(1),
              ) : null,
              child: Text(
                firstThrow ?? '1st',
                style: firstThrow == null ? const TextStyle(fontStyle: FontStyle.italic) : numberStyle,
              ),
            ),
          ),
          if (currentThrow == 2 || (currentThrow == null && (!frame.isStrike || isTenthFrame)) || currentThrow == 3)
            ThrowBox(
              showBorder: true,
              child: TextButton(
                onPressed: enabled ? () => _showSelectionPopup(
                  context: context,
                  ballThrow: 2,
                  options: _filterOptions(2),
                ) : null,
                child: Text(
                  secondThrow ?? '2nd',
                  style: secondThrow == null ? const TextStyle(fontStyle: FontStyle.italic) : numberStyle,
                ),
              ),
            ).animate().fade(),
          if (currentThrow == 3 || (currentThrow == null && isTenthFrame && tenthFrame!.hasThirdThrow))
            ThrowBox(
              showBorder: true,
              child: TextButton(
                onPressed: enabled ? () => _showSelectionPopup(
                  context: context,
                  ballThrow: 3,
                  options: _filterOptions(3),
                ) : null,
                child: Text(
                  thirdThrow ?? '3rd',
                  style: thirdThrow == null ? const TextStyle(fontStyle: FontStyle.italic) : numberStyle,
                ),
              ),
            ).animate().fade(),
        ],
      ),
    );
  }

  void _showSelectionPopup({
    required BuildContext context,
    required int ballThrow,
    List<String> options = options,
  }) {
    showPopover(
      context: context,
      backgroundColor: Colors.black54,
      direction: PopoverDirection.top,
      transitionDuration: const Duration(milliseconds: 100),
      bodyBuilder: (context) {
        return Container(
          width: 150,
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            children: [
              for (final option in options)
                IconButton(
                  onPressed: () {
                    _optionSelected(ballThrow, option);
                    context.pop();
                  },
                  icon: Text(
                    option,
                    style: context.textStyles.bodyLarge,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<String> _filterOptions(int ballThrow) {
    if (ballThrow == 1) {
      return List.unmodifiable(options.toList()..remove('/'));
    }

    if (ballThrow == 2) {
      if (!frame.isStrike) {
        final maxPins = 10 - (frame.firstThrow ?? 0) - 1;
        final result = options.take(maxPins).toList()
          ..add(endash)
          ..add('/');

        return List.unmodifiable(result);
      }

      return List.unmodifiable(options.toList()..remove('/'));
    }

    // ballThrow == 3
    if (frame.isSpare || frame.secondThrow == 10) {
      return List.unmodifiable(options.toList()..remove('/'));
    }

    final maxPins = 10 - (frame.secondThrow ?? 0) - 1;
    final result = options.take(maxPins).toList()
      ..add(endash)
      ..add('/');

    return List.unmodifiable(result);
  }

  void _optionSelected(int ballThrow, String option) {
    onSelected?.call(
      ballThrow,
      switch (option) {
        endash => 0,
        '/' => 10 - ((ballThrow != 3 ? frame.firstThrow : frame.secondThrow) ?? 0),
        'X' => 10,
        _ => int.tryParse(option)!,
      },
    );
  }
}

class ThrowBox extends StatelessWidget {
  final Widget? child;
  final double size;
  final bool showBorder;

  const ThrowBox({super.key, this.child, this.size = 54.0, this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: showBorder
          ? const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey),
              ),
            )
          : null,
      child: child,
    );
  }
}

extension FrameIntX on int? {
  String? toThrowString() {
    return switch (this) {
      null => null,
      0 => endash,
      10 => 'X',
      _ => toString(),
    };
  }
}
