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

  SegmentedButton<bool> selectScreen(BuildContext context) {
    return SegmentedButton<bool>(
      style: SegmentedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(4),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.padded,
        visualDensity: VisualDensity(),
      ),
      showSelectedIcon: false,
      segments: [
        ButtonSegment(
          label: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Text('Crear cuenta'),
          ),
          value: true,
        ),
        ButtonSegment(
          label: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Text('Ingresar'),
          ),
          value: false,
        ),
      ],
      selected: <bool>{register},
      onSelectionChanged: (Set<bool> newSelection) {
        setState(() {
          register = newSelection.first;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: register ? registerScreen(context) : loginScreen(context),
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
      ),
      Text(
        'Tu historial financiero, guardado y seguro',
        style: TextTheme.of(context).bodyLarge?.copyWith(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 13,
        ),
      ),
      SizedBox(height: 10),
      selectScreen(context),
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
      ),
      Text(
        'Ingresa para ver tus finanzas',
        style: TextTheme.of(context).bodyLarge?.copyWith(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 13,
        ),
      ),
      SizedBox(height: 10),
      selectScreen(context),
    ];
  }
}
