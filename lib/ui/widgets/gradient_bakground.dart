import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  // 160 degrees: starts top-rightish, goes bottom-leftish
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF042F2E), // 0% stop
                    Color(0xFF0D6259), // 58% stop
                    Color(0xFF0891B2), // 100% stop
                  ],
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
