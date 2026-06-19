import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});
  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  final UserController _userController = Get.find();
  bool hideNumbers = false;

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
    TextStyle? littleTextStyle = TextTheme.of(
      context,
    ).bodyMedium?.copyWith(color: Colors.white.withValues(alpha: 0.8));

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
          flexibleSpace: GradientBackground(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 16, 15, 25),
              child: Column(
                spacing: 20,
                mainAxisAlignment: .end,
                crossAxisAlignment: .start,
                children: [
                  Text(dateFormat(), style: littleTextStyle),
                  Spacer(),
                  Text('Vas bien', style: littleTextStyle),
                  Text(
                    hideNumbers
                        ? '****'
                        : '\$ ${_userController.getLoggedUser()?.getBudget().toString()}',
                    style: TextTheme.of(context).displayLarge?.copyWith(
                      fontWeight: .bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Disponible para gastar de tu presupuesto',
                    style: littleTextStyle,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverFloatingHeader(child: Text('Bolsillos')),
      ],
    );
  }
}
