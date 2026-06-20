import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/u_budget_page_widgets/budget_card.dart';
import 'package:tester/ui/widgets/u_budget_page_widgets/income_card.dart';

class UserBudgetPage extends StatefulWidget {
  const UserBudgetPage({super.key});

  @override
  State<UserBudgetPage> createState() => _UserBudgetPageState();
}

class _UserBudgetPageState extends State<UserBudgetPage> {
  final Color slateColor = Color.fromARGB(150, 100, 116, 139);
  final UserController _userController = Get.find();
  bool editIncome = false;
  bool editBudget = false;
  @override
  Widget build(BuildContext context) {
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
                text: 'CONTROL\n',
                style: TextTheme.of(
                  context,
                ).labelLarge?.copyWith(color: slateColor),
                children: [
                  TextSpan(
                    text: 'Presupuesto',
                    style: TextTheme.of(
                      context,
                    ).headlineLarge?.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: IncomeCard(
            income: _userController.getLoggedUser()!.getIncome(),
            editMode: editIncome,
            onEditClicked: () => setState(() {
              editIncome = true;
            }),
            onExitClicked: () => setState(() {
              editIncome = false;
            }),
            onSaveClicked: () => setState(() {
              editIncome = false;
            }),
          ),
        ),
        SliverToBoxAdapter(
          child: BudgetCard(
            editMode: editBudget,
            budget: _userController.getLoggedUser()!.getBudget(),
            spent: 0,
            onEditClicked: () => setState(() {
              editBudget = true;
            }),
            onExitClicked: () => setState(() {
              editBudget = false;
            }),
            onSaveClicked: () => setState(() {
              editBudget = false;
            }),
          ),
        ),
      ],
    );
  }
}
