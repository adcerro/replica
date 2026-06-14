import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              child: Icon(
                Icons.bar_chart_rounded,
                color: Colors.white,
                size: 70,
              ),
            ),
            Text(
              'Intranquilo',
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
              style: TextTheme.of(context).bodySmall?.copyWith(
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
                textStyle: TextTheme.of(context).labelLarge?.copyWith(
                  fontWeight: FontWeight(700),
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Get.toNamed('/welcome_info');
              },
              child: Text('Empezar →'),
            ),
          ],
        ),
      ),
    );
  }
}
