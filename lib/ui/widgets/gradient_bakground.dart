import 'package:flutter/material.dart';

enum GradientBackgroundColor { okay, warning, danger }

class GradientBackground extends StatelessWidget {
  final Widget child;
  final GradientBackgroundColor color;

  const GradientBackground({
    super.key,
    required this.child,
    this.color = .okay,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final topCircleSize = 288.0;
        final bottomCircleSize = 256.0;
        return Stack(
          children: [
            // 1. Base Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // 160 degrees: starts top-rightish, goes bottom-leftish
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: switch (color) {
                    GradientBackgroundColor.danger => [
                      Color(0xFF2D0A0A),
                      Color(0xFFB02020), // 58% stop
                      Color(0xFFF87171),
                    ],
                    GradientBackgroundColor.warning => [
                      Color(0xFF1C0F00),
                      Color(0xFFA05209), // 58% stop
                      Color(0xFFF0C040),
                    ],
                    _ => [
                      Color(0xFF042F2E),
                      Color(0xFF0D6259), // 58% stop
                      Color(0xFF0891B2),
                    ],
                  },
                  stops: [0.0, 0.58, 1.0],
                ),
              ),
            ),
            // 2. Top-Right Circle
            Positioned(
              top: -topCircleSize / 3,
              right: -topCircleSize / 3,
              child: Container(
                width: topCircleSize,
                height: topCircleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            // 3. Bottom-Left Circle
            Positioned(
              bottom: -bottomCircleSize / 3,
              left: -bottomCircleSize / 3,
              child: Container(
                width: bottomCircleSize,
                height: bottomCircleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),

            // 4. Foreground Content (Centered just like the original landing page)
            SafeArea(child: SizedBox.expand(child: child)),
          ],
        );
      },
    );
  }
}
