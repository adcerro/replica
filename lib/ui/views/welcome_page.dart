import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            CircleAvatar(),
            Text(
              'Tranquilo',
              style: TextTheme.of(context).displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight(700),
              ),
            ),
            Text(
              'Tu espacio financiero,\nen paz',
              style: TextTheme.of(context).displaySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 18,
                fontWeight: FontWeight(500),
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Registra, protege y entiende\ntus finanzas personales.',
              style: TextTheme.of(context).labelSmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(360, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text('Empezar →'),
            ),
          ],
        ),
      ),
    );
  }
}
