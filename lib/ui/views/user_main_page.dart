import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';
import 'package:tester/ui/widgets/pocket_card.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});
  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final UserController _userController = Get.find();
  final TransactionController _transactionController = Get.find();
  bool hideNumbers = false;
  GradientBackgroundColor bgColor = .okay;

  String dateFormat() {
    DateTime date = DateTime.now().toLocal();
    String weekDay = switch (date.weekday) {
      1 => 'Lunes',
      2 => 'Martes',
      3 => 'Miércoles',
      4 => 'Jueves',
      5 => 'Viernes',
      6 => 'Sábado',
      7 => 'Domingo',
      _ => '',
    };
    String month = switch (date.month) {
      1 => 'Enero',
      2 => 'Febrero',
      3 => 'Marzo',
      4 => 'Abril',
      5 => 'Mayo',
      6 => 'Junio',
      7 => 'Julio',
      8 => 'Agosto',
      9 => 'Septiembre',
      10 => 'Octubre',
      11 => 'Noviembre',
      12 => 'Diciembre',
      _ => '',
    };
    return '$weekDay, ${date.day} de $month';
  }

  @override
  Widget build(BuildContext context) {
    if (_userController.getLoggedUser() == null) {
      Get.offAllNamed('/start');
    }
    TextStyle? littleTextStyle = TextTheme.of(
      context,
    ).bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.8));
    double spentFraction =
        _transactionController
            .getMonthTotal(month: DateTime.now().month)
            .abs() /
        _userController.getLoggedUser()!.budget;
    double remainingBudget =
        _userController.getLoggedUser()!.budget -
        _transactionController.getMonthTotal(month: DateTime.now().month).abs();

    String statusMessage = 'Vas bien';
    if (spentFraction >= 0.5 && spentFraction < 0.7) {
      statusMessage = 'Cuidado, vas por encima';
      bgColor = .warning;
    } else if (spentFraction > 0.7) {
      statusMessage = 'Te estas pasando';
      bgColor = .danger;
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          floating: true,
          stretchTriggerOffset: 100,
          collapsedHeight: 300,
          expandedHeight: 300,
          title: Row(
            children: [
              Spacer(),
              PopupMenuButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.white24),
                ),
                icon: Icon(Icons.menu),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text('Ocultar montos ${hideNumbers ? '✓' : ''}'),
                      onTap: () {
                        setState(() {
                          hideNumbers = !hideNumbers;
                        });
                      },
                    ),
                  ];
                },
              ),
            ],
          ),
          flexibleSpace: ClipRRect(
            borderRadius: .circular(14),
            child: GradientBackground(
              color: bgColor,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 16, 15, 25),
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: .end,
                  crossAxisAlignment: .start,
                  children: [
                    Text(dateFormat(), style: littleTextStyle),
                    Spacer(),
                    Text(statusMessage, style: littleTextStyle),
                    Text(
                      hideNumbers ? '****' : '\$ $remainingBudget',
                      style: TextTheme.of(context).displayLarge?.copyWith(
                        fontWeight: .bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Disponible para gastar de tu presupuesto',
                      style: littleTextStyle,
                    ),
                    LinearProgressIndicator(
                      value: spentFraction,
                      minHeight: 15,
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      color: switch (bgColor) {
                        .danger => Color(0xFFF87171),
                        .warning => Color(0xFFF0C040),
                        _ => Color(0xFF0891B2),
                      },
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverFloatingHeader(
          child: Row(
            mainAxisSize: .min,
            children: [
              Container(
                height: 15,
                width: 5,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Text(
                'Bolsillos',
                style: TextTheme.of(context).labelLarge?.copyWith(
                  color: Color.fromARGB(150, 100, 116, 139),
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: kElevationToShadow[1],
            ),
            child: Column(
              children: [
                PocketCard(
                  foregroundColor: Colors.blue,
                  emojiIcon: '🎮',
                  title: 'Recreación',
                  spent: 0,
                  budget: 0,
                  completion: 0,
                  hideAmmounts: hideNumbers,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
