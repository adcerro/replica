import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';
import 'package:tester/ui/widgets/u_trans_page_widgets/no_transaction_container.dart';
import 'package:tester/ui/widgets/u_trans_page_widgets/transaction_list_tile.dart';
import 'package:tester/ui/widgets/u_trans_page_widgets/transaction_modal_sheet.dart';
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
  late Future<List<Transaction>?> userTransactions;

  @override
  void initState() {
    super.initState();
    userTransactions = _transactionController.getUserTransactions(
      userEmail: user!.email,
    );
  }

  void addTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionModalSheet(
        onSaveClicked: (transaction) async {
          await _transactionController.addTransaction(transaction: transaction);
          setState(() {
            userTransactions = _transactionController.getUserTransactions(
              userEmail: _userController.getLoggedUser()!.email,
            );
          });
        },
      ),
    );
  }

  void editTransaction(Transaction transaction) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionModalSheet(
        baseTransaction: transaction,
        onSaveClicked: (transaction) async {
          await _transactionController.updateTransaction(
            transaction: transaction,
          );
          setState(() {
            userTransactions = _transactionController.getUserTransactions(
              userEmail: _userController.getLoggedUser()!.email,
            );
          });
        },
      ),
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
          future: userTransactions,
          initialData: [],
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
                child: NoTransactionContainer(onCreate: addTransaction),
              );
            }
            List<MapEntry<DateTime, List<Transaction>>> groupedTransactions =
                _transactionController
                    .groupTransactionsByDate()
                    .reversed
                    .toList();

            return SliverList.builder(
              itemCount: groupedTransactions.length,
              itemBuilder: (context, index) {
                MapEntry<DateTime, List<Transaction>> entry =
                    groupedTransactions[index];
                double totalForDate = 0;
                for (Transaction trans in entry.value) {
                  totalForDate += trans.value;
                }
                return Padding(
                  padding: .all(15),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            '${entry.key.day}/${entry.key.month}/${entry.key.year}',
                            style: TextTheme.of(context).labelMedium?.copyWith(
                              color: slateColor,
                              fontWeight: .bold,
                            ),
                          ),
                          Expanded(child: Divider(thickness: 0.25)),
                          Text(
                            '\$ ${totalForDate.abs()}',
                            style: TextTheme.of(context).labelMedium?.copyWith(
                              color: slateColor,
                              fontWeight: .bold,
                            ),
                          ),
                        ],
                      ),
                      ...entry.value.map(
                        (transaction) => TransactionListTile(
                          transaction: transaction,
                          onDelete: () async {
                            await _transactionController.deleteTransaction(
                              transaction: transaction,
                            );
                            setState(() {
                              userTransactions = _transactionController
                                  .getUserTransactions(
                                    userEmail: _userController
                                        .getLoggedUser()!
                                        .email,
                                  );
                            });
                          },
                          onEdit: () {
                            editTransaction(transaction);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
