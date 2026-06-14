import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool register = Get.arguments['register'];

  AnimatedToggleSwitch<bool> registerLoginToggle(BuildContext context) {
    TextStyle? optionTextStyle = TextTheme.of(context).labelSmall?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 13,
      color: Colors.white.withValues(alpha: 0.7),
    );
    return AnimatedToggleSwitch<bool>.size(
      current: register,
      values: const [true, false],
      indicatorSize: const Size.fromWidth(190),
      height: 60,
      style: ToggleStyle(
        borderColor: Colors.transparent,
        backgroundColor: Colors.white.withValues(alpha: 0.08),
        indicatorColor: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        indicatorBorderRadius: BorderRadius.circular(12),
      ),
      iconList: [
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text('Crear cuenta', style: optionTextStyle),
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text('Ingresar', style: optionTextStyle),
        ),
      ],
      onChanged: (value) {
        setState(() {
          register = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Center(
        child: SizedBox(
          width: 360,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: register ? registerScreen(context) : loginScreen(context),
          ),
        ),
      ),
    );
  }

  List<Widget> registerScreen(BuildContext context) {
    return [
      Text(
        'Crea tu espacio',
        style: TextTheme.of(context).titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        'Tu historial financiero, guardado y seguro',
        style: TextTheme.of(context).bodyLarge?.copyWith(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 10),
      registerLoginToggle(context),
    ];
  }

  List<Widget> loginScreen(BuildContext context) {
    return [
      Text(
        'Bienvenido de vuelta',
        style: TextTheme.of(context).titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 26,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        'Ingresa para ver tus finanzas',
        style: TextTheme.of(context).bodyLarge?.copyWith(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 10),
      registerLoginToggle(context),
    ];
  }
}
