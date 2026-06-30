import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/custom_text_field.dart';
import 'package:tester/ui/widgets/gradient_bakground.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool register = Get.arguments['register'];
  final UserController _userController = Get.find();

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

  Future<void> guestLogin() async {
    if (await _userController.logUser(
          email: 'guest@user',
          password: 'guestpass',
        ) !=
        null) {
      logInfo('Logged in as local user');
      Get.offAllNamed('/user');
    } else {
      Get.toNamed('/income');
    }
  }

  TextButton returnButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        '← Volver',
        style: TextTheme.of(
          context,
        ).bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.65)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              children: register
                  ? registerScreen(context)
                  : loginScreen(context),
            ),
          ),
        ),
      ),
    );
  }

  bool acceptTerms = false;

  List<Widget> registerScreen(BuildContext context) {
    final underlinedStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.85),
      decoration: TextDecoration.underline,
      decorationColor: Colors.white,
      decorationThickness: 2,
    );
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(360, 50),
      disabledBackgroundColor: Colors.white.withValues(alpha: 0.45),
      disabledForegroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      textStyle: TextTheme.of(
        context,
      ).labelLarge?.copyWith(fontWeight: FontWeight(700), fontSize: 16),
    );
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
      Form(
        child: Column(
          spacing: 12,
          children: [
            CustomTextField(hintText: 'tu@email.com'),
            CustomTextField(hintText: 'Contraseña'),
            CustomTextField(hintText: 'Confirmar contraseña'),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.white.withValues(alpha: 0.2),
                  checkColor: Colors.white.withValues(alpha: 0.8),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
                  value: acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      acceptTerms = !acceptTerms;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    style: TextTheme.of(context).bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                    TextSpan(
                      text: 'He leído y acepto la ',
                      children: [
                        TextSpan(
                          text: 'política de privacidad',
                          style: underlinedStyle,
                        ),
                        TextSpan(text: ' y los '),
                        TextSpan(
                          text: 'términos y condiciones',
                          style: underlinedStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: acceptTerms
                  ? () {
                      Get.showSnackbar(
                        GetSnackBar(
                          title: ':(',
                          message: 'No Implementado',
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  : null,
              child: Text('Crear cuenta →'),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                ),
                Text(
                  'o',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                ),
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                ),
              ],
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: acceptTerms
                  ? () {
                      Get.showSnackbar(
                        GetSnackBar(
                          title: ':(',
                          message: 'No Implementado',
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  : null,
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.google),
                  Text('Continuar con Google'),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: guestLogin,
              child: Text(
                'Continuar sin cuenta',
                style: TextTheme.of(context).bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
            ),
            Text(
              'Solo se guarda en este dispositivo',
              style: TextTheme.of(context).bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.42),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      returnButton(context),
    ];
  }

  List<Widget> loginScreen(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size(360, 50),
      disabledBackgroundColor: Colors.white.withValues(alpha: 0.45),
      disabledForegroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      textStyle: TextTheme.of(
        context,
      ).labelLarge?.copyWith(fontWeight: FontWeight(700), fontSize: 16),
    );
    final underlinedStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.38),
      decoration: TextDecoration.underline,
      decorationColor: Colors.white.withValues(alpha: 0.38),
      decorationThickness: 2,
    );
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
      Form(
        child: Column(
          spacing: 12,
          children: [
            CustomTextField(hintText: 'tu@email.com'),
            CustomTextField(hintText: 'Contraseña'),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Get.showSnackbar(
                  GetSnackBar(
                    title: ':(',
                    message: 'No Implementado',
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Ingresar →'),
            ),
            TextButton(
              onPressed: () {
                Get.showSnackbar(
                  GetSnackBar(
                    title: ':(',
                    message: 'No Implementado',
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextTheme.of(context).bodySmall?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white.withValues(alpha: 0.45),
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                ),
                Text(
                  'o',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                ),
                Expanded(
                  child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                ),
              ],
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Get.showSnackbar(
                  GetSnackBar(
                    title: ':(',
                    message: 'No Implementado',
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.google),
                  Text('Continuar con Google'),
                ],
              ),
            ),
            TextButton(
              onPressed: guestLogin,
              child: Text(
                'Continuar sin cuenta',
                style: TextTheme.of(context).bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
            ),
            Text(
              'Solo se guarda en este dispositivo',
              style: TextTheme.of(context).bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.42),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      returnButton(context),
      Text.rich(
        textAlign: TextAlign.center,
        style: TextTheme.of(context).bodySmall?.copyWith(
          color: Colors.white.withValues(alpha: 0.38),
          fontSize: 10,
        ),
        TextSpan(
          text: 'Al usar Intranquilo aceptas nuestros ',
          children: [
            TextSpan(text: 'Términos', style: underlinedStyle),
            TextSpan(text: ' y nuestra '),
            TextSpan(text: 'Política de Privacidad', style: underlinedStyle),
          ],
        ),
      ),
    ];
  }
}
