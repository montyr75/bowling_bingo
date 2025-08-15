import 'dart:math' as math;

import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../data/challenge_responses.dart';
import '../utils/popup_utils.dart';
import '../utils/screen_utils.dart';
import '../utils/utils.dart';

class ChallengeConfirmationDialog extends StatefulWidget {
  final bool isSuccess;
  final Widget title;
  final Widget content;
  final List<Widget> actions;

  const ChallengeConfirmationDialog({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.content,
    required this.actions,
  });

  @override
  State<ChallengeConfirmationDialog> createState() => _ChallengeConfirmationDialogState();

  static Future<void> show({
    required bool isSuccess,
    String? title,
    String? yesMsg,
    String? noMsg,
    required VoidCallback onConfirm,
  }) {
    return SmartDialog.show(
      clickMaskDismiss: false,
      builder: (_) {
        return ChallengeConfirmationDialog(
          isSuccess: isSuccess,
          title: Text(title ?? (isSuccess ? "Success!" : "Failure!")),
          content: Text(isSuccess ? successResponses.randomElement() : failureResponses.randomElement()),
          actions: [
            TextButton(
              onPressed: SmartDialog.dismiss,
              child: Text(noMsg ?? "Cancel", style: const TextStyle(color: Colors.white70)),
            ),
            boxL,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isSuccess ? Colors.green.shade600 : Colors.red.shade600,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                SmartDialog.dismiss();
                onConfirm();
              },
              child: Text(yesMsg ?? "Confirm"),
            ),
          ],
        );
      },
    );
  }
}

class _ChallengeConfirmationDialogState extends State<ChallengeConfirmationDialog> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = widget.isSuccess;
    final styles = context.textStyles;
    final borderColor = isSuccess ? Colors.green.shade300 : Colors.red.shade400;
    final backgroundColor = isSuccess ? const Color(0xFF2E4053) : const Color(0xFF212121);
    final titleStyle = isSuccess
        ? styles.titleLarge.copyWith(color: Colors.yellowAccent.shade100)
        : styles.titleLarge.copyWith(color: Colors.red.shade200);

    final dialogContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: titleStyle,
          child: widget.title,
        ),
        boxXXL,
        DefaultTextStyle(
          style: styles.bodyLarge,
          child: widget.content,
        ),
        boxXXL,
        Row(mainAxisAlignment: MainAxisAlignment.end, children: widget.actions),
      ],
    );

    return Container(
      padding: paddingAllXXL,
      constraints: const BoxConstraints(maxWidth: dialogMaxWidth),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 3),
        borderRadius: const BorderRadius.all(Radius.circular(xl)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 128),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: CustomPaint(
        painter: isSuccess
            ? _FireworksPainter(animation: _animationController)
            : _RainPainter(animation: _animationController),
        child: dialogContent,
      ),
    );
  }
}

class _FireworksPainter extends CustomPainter {
  final Animation<double> animation;
  final List<_Firework> fireworks;

  _FireworksPainter({required this.animation})
    : fireworks = List.generate(5, (index) => _Firework()),
      super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (final firework in fireworks) {
      firework.draw(canvas, size, animation.value, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _FireworksPainter oldDelegate) => false;
}

class _Firework {
  final double startTime;
  final double duration;
  final Offset center;
  final List<_Particle> particles;

  _Firework()
    : startTime = math.Random().nextDouble(),
      duration = math.Random().nextDouble() * 0.4 + 0.2,
      center = Offset(math.Random().nextDouble(), math.Random().nextDouble()),
      particles = List.generate(
        100,
        (index) => _Particle(
          color: _getRandomColor(),
          speed: math.Random().nextDouble() * 4 + 1,
          angle: math.Random().nextDouble() * 2 * math.pi,
        ),
      );

  static Color _getRandomColor() {
    return [
      Colors.red,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.orange,
    ][math.Random().nextInt(6)];
  }

  void draw(Canvas canvas, Size size, double time, Paint paint) {
    // Calculate progress, allowing for animation loop wrap-around.
    final double progress;
    if (time >= startTime) {
      progress = (time - startTime) / duration;
    } else {
      // The animation has looped. Treat time as if it's > 1.0.
      progress = (time + 1.0 - startTime) / duration;
    }

    if (progress < 0 || progress > 1) return;

    final explosionProgress = Curves.easeOut.transform(progress);
    final fadeProgress = Curves.easeIn.transform(progress);

    for (final particle in particles) {
      final particlePath = Offset.fromDirection(
        particle.angle,
        explosionProgress * particle.speed * (size.width * 0.05),
      );
      final position = Offset(center.dx * size.width, center.dy * size.height) + particlePath;

      final particleOpacity = 1.0 - fadeProgress;
      paint.color = particle.color.withValues(alpha: particleOpacity.clamp(0.0, 1.0));
      canvas.drawCircle(position, 2.0, paint);
    }
  }
}

class _Particle {
  final Color color;
  final double speed;
  final double angle;

  _Particle({
    required this.color,
    required this.speed,
    required this.angle,
  });
}

class _RainPainter extends CustomPainter {
  final Animation<double> animation;
  final List<_RainDrop> raindrops;

  _RainPainter({required this.animation})
    : raindrops = List.generate(100, (index) => _RainDrop()),
      super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final time = animation.value;

    // Create a fade-in and fade-out effect to make the loop seamless.
    final double overallOpacity;
    if (time < 0.15) {
      // Fade in for the first 15% of the animation.
      overallOpacity = time / 0.15;
    } else if (time > 0.85) {
      // Fade out for the last 15% of the animation.
      overallOpacity = (1.0 - time) / 0.15;
    } else {
      overallOpacity = 1.0;
    }

    if (overallOpacity <= 0) return;

    final paint = Paint()
      ..color = Colors.blueGrey.shade300.withValues(alpha: 0.6 * overallOpacity)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (final drop in raindrops) {
      final progress = (drop.initialY + time * drop.fallSpeed) % 1.0;
      final x = drop.initialX * size.width;
      final y = progress * size.height;
      canvas.drawLine(Offset(x, y), Offset(x + drop.angleX, y + drop.length), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RainPainter oldDelegate) => false;
}

class _RainDrop {
  final double initialX;
  final double initialY;
  final double length;
  final double fallSpeed;
  final double angleX;

  _RainDrop()
    : initialX = math.Random().nextDouble(),
      initialY = math.Random().nextDouble(),
      length = math.Random().nextDouble() * 10 + 5,
      fallSpeed = math.Random().nextDouble() * 0.4 + 0.4,
      angleX = math.Random().nextDouble() * 2 - 1;
}
