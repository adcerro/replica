import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/ui/views/income_page.dart';
import 'package:tester/ui/views/start_page.dart';
import 'package:tester/ui/views/welcome_info_page.dart';
import 'package:tester/ui/views/welcome_page.dart';

void main() async {
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('users');
  await Hive.openBox('transactions');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intranquilo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(5, 28, 27, 0),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.geistTextTheme(),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => WelcomePage()),
        GetPage(name: '/welcome_info', page: () => WelcomeInfoPage()),
        GetPage(name: '/start', page: () => StartPage()),
        GetPage(name: '/income', page: () => IncomePage()),
      ],
    );
  }
}
