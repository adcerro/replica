import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                  'Revisar configuración',
                  style: TextTheme.of(context).labelLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                Text(''),
                Container(),
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
                  onPressed: () async {
                    //if (userController.getLoggedUser() == null) {
                    //  await userController.guestUserMode(
                    //    income: income,
                    //    budget: budgetFieldController.text.isEmpty
                    //        ? 0.0
                    //        : double.parse(budgetFieldController.text),
                    //  );
                    //}
                    Get.toNamed('/user');
                  },
                  child: Text('Continuar →'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    //if (userController.getLoggedUser() == null) {
                    //  await userController.guestUserMode(
                    //    income: income,
                    //    budget: 0.0,
                    //  );
                    //}
                    Get.toNamed('/user');
                  },
                  child: Text(
                    'Continuar sin presupuesto',
                    style: TextTheme.of(context).bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    '← Volver',
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
