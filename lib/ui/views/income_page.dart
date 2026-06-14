import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D6259),
      body: GradientBackground(
        child: Center(
          child: Column(
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
                style: TextTheme.of(
                  context,
                ).titleLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
