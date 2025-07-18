import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/screen_utils.dart';
import 'bowling_tip.dart';
import 'game_bar.dart';
import 'stats_page.dart';

class GamePageWrapper extends ConsumerWidget {
  final String bgImagePath;
  final bool showBowlingTip;
  final List<Widget> children;

  const GamePageWrapper({
    super.key,
    required this.bgImagePath,
    this.showBowlingTip = false,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: BackdropScaffold(
        appBar: buildGameBar(),
        maintainBackLayerState: false,
        backLayerBackgroundColor: Colors.black,
        backLayer: const StatsPage(),
        frontLayer: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImagePath),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: children,
                        ),
                      ),
                    ),
                    if (showBowlingTip) ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 350.0),
                      child: const BowlingTip(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
