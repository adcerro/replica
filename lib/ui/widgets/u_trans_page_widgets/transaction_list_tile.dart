import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/ui/controllers/user_controller.dart';

class TransactionListTile extends StatelessWidget {
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  final Transaction transaction;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  const TransactionListTile({
    super.key,
    required this.transaction,
    this.onEdit,
    this.onDelete,
  });
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: userController
              .getLoggedUser()!
              .categories[transaction.category]!['color']
              .withValues(alpha: 0.1),
        ),
        borderRadius: .circular(12),
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: slateColor,
          borderRadius: .circular(12),
        ),
        alignment: .center,
        child: Text(
          userController
              .getLoggedUser()!
              .categories[transaction.category]!['icon'],
          style: TextStyle(fontSize: 20),
        ),
      ),
      title: Text(transaction.label),
      subtitle: Text(
        transaction.category.isEmpty ? 'Sin categoría' : transaction.category,
      ),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          Text(
            transaction.value.abs().toString(),
            style: TextTheme.of(
              context,
            ).bodyMedium?.copyWith(fontWeight: .bold),
          ),
          IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
          IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
