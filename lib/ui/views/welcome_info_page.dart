import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/widgets/custom_card.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class WelcomeInfoPage extends StatelessWidget {
  const WelcomeInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    final cardLeadingStyle = TextTheme.of(context).displaySmall;
    final cardTitleStyle = TextTheme.of(context).titleMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight(600),
      fontSize: 14,
    );
    final cardSubtitleStyle = TextTheme.of(context).bodySmall?.copyWith(
      color: Colors.white.withValues(alpha: 0.75),
      fontSize: 12,
    );
    return Scaffold(
      backgroundColor: Color(0xFF0D6259),
      body: GradientBackground(
        child: Center(
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 10,
              children: [
                Text(
                  'Lo que vas a lograr',
                  style: TextTheme.of(context).displayLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight(700),
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Simple, seguro y solo tuyo',
                  style: TextTheme.of(context).labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CustomCard(
                  leading: Text('🔒', style: cardLeadingStyle),
                  title: Text('Tus datos, protegidos', style: cardTitleStyle),
                  subtitle: Text(
                    'Solo tú accedes a tu información financiera',
                    style: cardSubtitleStyle,
                    maxLines: 3,
                  ),
                ),
                CustomCard(
                  leading: Text('📊', style: cardLeadingStyle),
                  title: Text('Claridad real', style: cardTitleStyle),
                  subtitle: Text(
                    'Entiende a dónde va tu dinero cada mes',
                    style: cardSubtitleStyle,
                  ),
                ),
                CustomCard(
                  leading: Text('💚', style: cardLeadingStyle),
                  title: Text('Tranquilidad duradera', style: cardTitleStyle),
                  subtitle: Text(
                    'Sin sorpresas, sin estrés a fin de mes',
                    style: cardSubtitleStyle,
                  ),
                ),
                SizedBox(height: 10),
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
                    Get.toNamed('/start', arguments: {'register': true});
                  },
                  child: Text('Crear mi cuenta →'),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {
                    Get.toNamed('/start', arguments: {'register': false});
                  },
                  child: Text(
                    'Ya tengo cuenta',
                    style: TextTheme.of(context).bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
