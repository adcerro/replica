import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';

import '../../domain/entities/user.dart';
import '../controllers/user_controller.dart';

class UserInsightPage extends StatelessWidget {
  final Color slateColor = Color.fromARGB(150, 100, 116, 139);
  final UserController _userController = Get.find();
  final TransactionController _transactionController = Get.find();

  UserInsightPage({super.key});
  @override
  Widget build(BuildContext context) {
    final User? user = _userController.getLoggedUser();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          collapsedHeight: 120,
          flexibleSpace: Container(
            margin: .all(15),
            alignment: .bottomLeft,
            child: RichText(
              text: TextSpan(
                text: 'INSIGHTS\n',
                style: TextTheme.of(
                  context,
                ).labelLarge?.copyWith(color: slateColor),
                children: [
                  TextSpan(
                    text: 'Análisis',
                    style: TextTheme.of(
                      context,
                    ).headlineLarge?.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: _transactionController.getUserTransactions(
            userEmail: user!.getEmail(),
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
                          '📊',
                          style: TextTheme.of(context).headlineSmall,
                        ),
                      ),
                      Text(
                        'Registra gastos para ver tus análisis',
                        style: TextTheme.of(
                          context,
                        ).labelLarge?.copyWith(color: slateColor),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SliverList.builder(
              itemBuilder: (context, index) =>
                  ListTile(title: Text('${snapshot.data!.elementAt(index)}')),
              itemCount: snapshot.data!.length,
            );
          }),
        ),
      ],
    );
  }
}
