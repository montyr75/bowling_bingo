import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:backdrop/backdrop.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features/app/services/app/app_service.dart';
import '../features/bingo/services/game_service.dart';
import '../utils/screen_utils.dart';

AppBar buildGameBar() {
  return AppBar(
    toolbarHeight: 68,
    centerTitle: true,
    automaticallyImplyLeading: false,
    flexibleSpace: IntrinsicHeight(
      child: Consumer(
        builder: (context, ref, child) {
          final appState = ref.read(appServiceProvider);
          final gameState = ref.watch(gameServiceProvider);

          final styles = context.textStyles;

          return Stack(
            children: [
              CenterLeft(
                child: Padding(
                  padding: paddingAllM,
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          final bd = Backdrop.of(context);

                          if (bd.isBackLayerConcealed) {
                            bd.revealBackLayer();
                          } else {
                            bd.concealBackLayer();
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.bowlingBall),
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      appState.bowlerLevel.toString(),
                      style: styles.bodySmall.copyWith(fontStyle: FontStyle.italic),
                    ),
                    boxS,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Success Rate: ${gameState.history.percentSuccess}%",
                          style: styles.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CenterRight(
                child: Padding(
                  padding: const EdgeInsets.only(right: xl),
                  child: Text(
                    gameState.points.toString(),
                    style: styles.displaySmall.copyWith(fontSize: 24),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
