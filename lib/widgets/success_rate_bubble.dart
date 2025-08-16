import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/app/services/app/app_service.dart';
import '../features/bingo/services/game_service.dart';
import '../features/bingo/services/game_state.dart';
import '../utils/screen_utils.dart';
import '../utils/utils.dart';
import 'bg_bubble.dart';

class SuccessRateBubble extends ConsumerWidget {
  const SuccessRateBubble({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.read(appServiceProvider);
    final gameState = ref.read(gameServiceProvider);

    final textTheme = context.textTheme;

    return BgBubble(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Success Rate:",
                style: textTheme.headlineSmall,
              ),
              boxM,
              Text(
                "${gameState.history.percentSuccess}%",
                style: textTheme.headlineSmall,
              ),
            ],
          ),
          boxS,
          Text(
            appState.bowlerLevel.toString(),
            style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
