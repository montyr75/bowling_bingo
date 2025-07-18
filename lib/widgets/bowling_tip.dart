import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features/app/services/app/app_service.dart';
import '../utils/screen_utils.dart';

class BowlingTip extends ConsumerStatefulWidget {
  const BowlingTip({super.key});

  @override
  ConsumerState createState() => _BowlingTipState();
}

class _BowlingTipState extends ConsumerState<BowlingTip> {
  late final String tip;

  @override
  void initState() {
    super.initState();

    tip = ref.read(appServiceProvider.notifier).getBowlingTip();
  }

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Colors.blue,
      child: Padding(
        padding: paddingAllM,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(FontAwesomeIcons.bowlingBall),
            boxL,
            Expanded(child: Text(tip)),
          ],
        ),
      ),
    );
  }
}
