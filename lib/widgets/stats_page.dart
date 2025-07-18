import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/bingo/services/game_service.dart';
import '../utils/popup_utils.dart';
import '../utils/screen_utils.dart';
import 'score_sheet.dart';
import 'success_rate_bubble.dart';

class StatsPage extends ConsumerWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(gameServiceProvider);

    return DecoratedBox(
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
                    child: Column(
                      children: [
                        const SuccessRateBubble(),
                        boxXXL,
                        for (final history in state.history.values) ...[
                          boxXXL,
                          ScoreSheet(results: history),
                        ],
                        boxXXL,
                        ElevatedButton(
                          onPressed: () {
                            showConfirmDialog(
                              context: context,
                              title: "Are you sure?",
                              message: "You are about to quit your current game. This cannot be undone.",
                              yesMsg: "Confirm",
                              noMsg: "Cancel",
                              onConfirm: () => context.pop(),
                            );

                          },
                          child: const Text('Quit', style: TextStyle(fontSize: 18)),
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
    );
  }
}