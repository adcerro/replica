import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/entities/user.dart';
import 'package:tester/ui/controllers/transaction_controller.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/category_card.dart';
import 'package:tester/ui/widgets/u_budget_page_widgets/budget_card.dart';
import 'package:tester/ui/widgets/u_budget_page_widgets/income_card.dart';

import '../../domain/entities/category_info.dart';
import '../widgets/u_budget_page_widgets/create_category_card.dart';

class UserBudgetPage extends StatefulWidget {
  const UserBudgetPage({super.key});

  @override
  State<UserBudgetPage> createState() => _UserBudgetPageState();
}

class _UserBudgetPageState extends State<UserBudgetPage> {
  final Color slateColor = Color.fromARGB(150, 100, 116, 139);
  final UserController _userController = Get.find();
  final TransactionController _transactionController = Get.find();
  bool editIncome = false;
  bool editBudget = false;
  bool createCategory = false;
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
            income: _userController.getLoggedUser()!.income,
            editMode: editIncome,
            onEditClicked: () => setState(() {
              editIncome = true;
            }),
            onExitClicked: () => setState(() {
              editIncome = false;
            }),
            onSaveClicked: (income) async {
              User updatedUser = _userController.getLoggedUser()!;
              updatedUser.income = income;
              await _userController.updateUser(user: updatedUser);
              setState(() {
                editIncome = false;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: BudgetCard(
            editMode: editBudget,
            budget: _userController.getLoggedUser()!.budget,
            spent: _transactionController
                .getMonthTotal(month: DateTime.now().month)
                .abs(),
            onEditClicked: () => setState(() {
              editBudget = true;
            }),
            onExitClicked: () => setState(() {
              editBudget = false;
            }),
            onSaveClicked: (budget) async {
              User updatedUser = _userController.getLoggedUser()!;
              updatedUser.budget = budget;
              await _userController.updateUser(user: updatedUser);
              setState(() {
                editBudget = false;
              });
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: .all(15),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: .circular(14),
                  ),
                  height: 15,
                  width: 5,
                ),
                Text(
                  'BOLSILLOS',
                  style: TextTheme.of(
                    context,
                  ).labelLarge?.copyWith(color: slateColor),
                ),
                Spacer(),
                !createCategory
                    ? TextButton(
                        onPressed: () => setState(() {
                          createCategory = true;
                        }),
                        child: Text('+ Agregar'),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: createCategory
              ? CreateCategoryCard(
                  onCancelPressed: () => setState(() {
                    createCategory = false;
                  }),
                  onAddCategory: (categoryInfo) async {
                    if (categoryInfo['name'] == null ||
                        categoryInfo['name']!.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'El nombre del bolsillo no puede estar vacío.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }
                    await _userController.addCategory(
                      categoryName: categoryInfo['name']!,
                      categoryIcon: categoryInfo['icon']!,
                      categoryBudget:
                          double.tryParse(categoryInfo['budget'] ?? '0') ?? 0,
                    );
                    setState(() {
                      createCategory = false;
                    });
                  },
                )
              : SizedBox(),
        ),
        SliverGrid.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 130,
          ),
          itemCount: _userController.getLoggedUser()?.categories.length ?? 0,
          itemBuilder: (context, index) {
            String categoryName =
                _userController.getLoggedUser()?.categories.keys.elementAt(
                  index,
                ) ??
                '';
            CategoryInfo? categoryInfo = _userController
                .getLoggedUser()
                ?.categories[categoryName];
            return CategoryCard(
              foregroundColor: Color(categoryInfo?.color ?? 0xFF808080),
              emojiIcon: categoryInfo?.icon ?? '',
              title: categoryName,
              spent: 0,
              budget: categoryInfo?.budget ?? 0,
              hideAmmounts: false,
            );
          },
        ),
      ],
    );
  }
}
