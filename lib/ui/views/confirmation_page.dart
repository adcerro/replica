import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  Widget confirmationContainer(
    BuildContext context,
    double income,
    double budget,
  ) {
    TextStyle? leftStyle = TextTheme.of(
      context,
    ).bodySmall?.copyWith(color: Colors.white70);
    TextStyle? rightStyle = TextTheme.of(
      context,
    ).bodyLarge?.copyWith(color: Colors.white);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white10,
        border: Border.all(width: 15, color: Colors.transparent),
      ),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        spacing: 10,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: .start,
            children: [
              Text('Ingresos mensuales:', style: leftStyle),
              Text('Presupuesto:', style: leftStyle),
            ],
          ),
          Expanded(
            child: (Column(
              spacing: 10,
              crossAxisAlignment: .end,
              children: [
                Text('\$ $income', style: rightStyle),
                Text('\$ $budget', style: rightStyle),
              ],
            )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double income = Get.arguments['income'];
    double budget = Get.arguments['budget'];
    UserController userController = Get.find();
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
                Text(
                  'Verifica que todo sea correcto antes de empezar',
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                confirmationContainer(context, income, budget),
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
                    if (userController.getLoggedUser() == null) {
                      await userController.guestUserMode(
                        income: income,
                        budget: budget,
                      );
                    }
                    Get.toNamed('/user');
                  },
                  child: Text('Confirmar y empezar ✓'),
                ),
                const SizedBox(height: 10),
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
