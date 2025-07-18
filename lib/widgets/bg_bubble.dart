import 'package:flutter/material.dart';

import '../utils/screen_utils.dart';

class BgBubble extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const BgBubble({
    super.key,
    this.maxWidth = 350.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350.0),
      child: Card(
        color: Colors.black54,
        child: _buildInnerBox(),
      ),
    );
  }

  Widget _buildInnerBox() {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: Colors.grey, width: 2),
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: paddingAllM,
        child: child,
      ),
    );
  }
}
