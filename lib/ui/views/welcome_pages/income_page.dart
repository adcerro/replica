import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/ui/widgets/custom_text_field.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final incomeFieldController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFF0D6259),
      body: GradientBackground(
        child: Center(
          child: SizedBox(
            width: 320,
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 10),
                Text(
                  'Intranquilo',
                  style: TextTheme.of(context).titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Finanzas personales sin estrés',
                  style: TextTheme.of(
                    context,
                  ).labelLarge?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Text(
                  '¿Cuánto recibes al mes?',
                  style: TextTheme.of(context).labelLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 15, bottom: 15),
                  child: Form(
                    child: CustomTextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: incomeFieldController,
                      hintText: '2000000',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                    textStyle: TextTheme.of(
                      context,
                    ).labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    logInfo('Income set as ${incomeFieldController.text}');
                    Get.toNamed(
                      '/budget',
                      arguments: {
                        'income': incomeFieldController.text.isEmpty
                            ? 0.0
                            : double.parse(incomeFieldController.text),
                      },
                    );
                  },
                  child: Text('Continuar →'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    logInfo('Income set as 0');
                    Get.toNamed('/budget', arguments: {'income': 0.0});
                  },
                  child: Text(
                    'Continuar sin ingresos',
                    style: TextTheme.of(context).bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
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
