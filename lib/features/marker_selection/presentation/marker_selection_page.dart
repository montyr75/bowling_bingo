import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';
import '../../../utils/screen_utils.dart';
import '../../app/services/app/app_service.dart';
import '../../app/services/app/app_state.dart';

class MarkerSelectionPage extends ConsumerWidget {
  const MarkerSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingo Markers'),
      ),
      body: DecoratedBox(
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
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: lg,
                  crossAxisSpacing: lg,
                  children: BingoMarker.values
                      .map(
                        (marker) => MarkerOption(
                          marker: marker,
                          onSelected: (marker) {
                            ref.read(appServiceProvider.notifier).selectBingoMarker(marker);
                            context.goNamed(AppRoute.game.name);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MarkerOption extends StatelessWidget {
  final BingoMarker marker;
  final ValueChanged<BingoMarker> onSelected;

  const MarkerOption({super.key, required this.marker, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black45),
      onPressed: () => onSelected(marker),
      child: Image.asset(marker.assetPath),
    );
  }
}
