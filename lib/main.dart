import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/data/datasources/local/i_transaction_local_datasource.dart';
import 'package:tester/data/datasources/local/i_user_local_datasource.dart';
import 'package:tester/data/datasources/local/transaction_local_datasource.dart';
import 'package:tester/data/datasources/local/user_local_datasource.dart';
import 'package:tester/data/repositories/transaction_repository.dart';
import 'package:tester/data/repositories/user_repository.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/domain/entities/user.dart';
import 'package:tester/domain/repositories/i_transaction_repository.dart';
import 'package:tester/domain/repositories/i_user_repository.dart';
import 'package:tester/hive/hive_registrar.g.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/views/welcome_pages/budget_page.dart';
import 'package:tester/ui/views/welcome_pages/confirmation_page.dart';
import 'package:tester/ui/views/welcome_pages/income_page.dart';
import 'package:tester/ui/views/start_page.dart';
import 'package:tester/ui/views/user_pages.dart';
import 'package:tester/ui/views/welcome_pages/welcome_info_page.dart';
import 'package:tester/ui/views/welcome_pages/welcome_page.dart';

void main() async {
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();

  // Remove this line to keep the created users.
  await Hive.deleteBoxFromDisk('users');

  await Hive.openBox('settings');
  await Hive.openBox<User>('users');
  await Hive.openBox<Transaction>('transactions');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //Users
  Get.put<IUserLocalDataSource>(UserLocalDataSource());
  Get.put<IUserRepository>(UserRepository(userLocalDataSource: Get.find()));
  Get.put(UserController(userUseCase: Get.find()));

  //Transactions
  Get.put<ITransactionLocalDatasource>(TransactionLocalDatasource());
  Get.put<ITransactionRepository>(
    TransactionRepository(transactionLocalDataSource: Get.find()),
  );
  Get.put(TransactionController(transactionUseCase: Get.find()));

  runApp(const MyApp());
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
        GetPage(name: '/budget', page: () => BudgetPage()),
        GetPage(name: '/confirm', page: () => ConfirmationPage()),
        GetPage(name: '/user', page: () => UserPages()),
      ],
    );
  }
}
