import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';
import 'package:tester/ui/widgets/transaction_modal_sheet.dart';
import '../../domain/entities/user.dart';
import '../controllers/user_controller.dart';

class UserTransactionPage extends StatefulWidget {
  const UserTransactionPage({super.key});
  @override
  State<UserTransactionPage> createState() => _UserTransactionPageState();
}

class _UserTransactionPageState extends State<UserTransactionPage> {
  final UserController _userController = Get.find();
  final TransactionController _transactionController = Get.find();
  late User? user = _userController.getLoggedUser();
  final Color slateColor = Color.fromARGB(150, 100, 116, 139);

  void addTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_userController.getLoggedUser() == null) {
      Get.offAllNamed('/start');
    }
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          collapsedHeight: 120,
          flexibleSpace: Container(
            margin: .all(15),
            alignment: .bottomCenter,
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'REGISTRO\n',
                    style: TextTheme.of(
                      context,
                    ).labelLarge?.copyWith(color: slateColor),
                    children: [
                      TextSpan(
                        text: 'Movimientos',
                        style: TextTheme.of(
                          context,
                        ).headlineLarge?.copyWith(fontWeight: .bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    addTransaction();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: _transactionController.getUserTransactions(
            userEmail: user!.email,
          ),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) {
              return SliverFillRemaining(
                child: Center(child: Text('Error: ${snapshot.error}')),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: kElevationToShadow[1],
                  ),
                  margin: EdgeInsets.all(15),
                  height: MediaQuery.sizeOf(context).height / 4,
                  child: Column(
                    mainAxisAlignment: .center,
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '📋',
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      Text(
                        'Aún no hay movimientos',
                        style: TextTheme.of(
                          context,
                        ).labelLarge?.copyWith(color: slateColor),
                      ),
                      TextButton(
                        onPressed: () {
                          addTransaction();
                        },
                        child: Text(
                          'Agregar el primero',
                          style: TextTheme.of(context).labelLarge?.copyWith(
                            fontWeight: .bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverList.builder(
              itemBuilder: (context, index) => ListTile(title: Text('$index')),
              itemCount: snapshot.data!.length,
            );
          }),
        ),
      ],
    );
  }
}
