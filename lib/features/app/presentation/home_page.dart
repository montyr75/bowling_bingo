import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app_config.dart';
import '../../../data/bowler_levels.dart';
import '../../../routes.dart';
import '../../../utils/screen_utils.dart';
import '../../../widgets/bg_bubble.dart';
import '../services/app/app_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appServiceProvider);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            boxXXL,
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Image.asset('assets/images/logo.png'),
            ),
            boxXXL,
            BgBubble(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<BowlerLevel>(
                  value: state.bowlerLevel,
                  focusColor: Colors.transparent,
                  onChanged: (value) => ref.read(appServiceProvider.notifier).selectBowlerLevel(value!),
                  items: BowlerLevel.values.map<DropdownMenuItem<BowlerLevel>>((value) {
                    return DropdownMenuItem<BowlerLevel>(
                      value: value,
                      child: Text("$value (${value.toRange()} average)"),
                    );
                  }).toList(),
                ),
              ),
            ),
            boxXXL,
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.game.name),
              child: const Text('Play', style: TextStyle(fontSize: 18)),
            ),
            const Spacer(),
            const BgBubble(
              child: Text("v$version"),
            ),
          ],
        ),
      ),
    );
  }
}
