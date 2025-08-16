import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PageNavButton extends StatelessWidget {
  final String label;
  final ButtonColor color;
  final double? width;
  final VoidCallback onPressed;

  const PageNavButton({
    super.key,
    required this.label,
    this.color = ButtonColor.blue,
    this.width = 165.0,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          height: 40,
          child: InkWell(
            radius: 100,
            onTap: onPressed,
            child: Ink.image(
              image: AssetImage('assets/images/${color.name}_button.png'),
              fit: BoxFit.fill,
              child: Center(
                child: Transform.translate(
                  offset: const Offset(0, -2),
                  child: Text(
                    label,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonColor {
  blue,
  green,
  red;
}