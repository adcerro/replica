import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final bool editMode;
  final double budget;
  final double spent;
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  final VoidCallback? onEditClicked;
  final VoidCallback? onExitClicked;
  final VoidCallback? onSaveClicked;

  const BudgetCard({
    super.key,
    this.budget = 0,
    this.spent = 0,
    this.editMode = false,
    this.onEditClicked,
    this.onExitClicked,
    this.onSaveClicked,
  });
  Widget normalBuild(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: .start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'PRESUPUESTO A GASTAR',
              style: TextTheme.of(
                context,
              ).labelSmall?.copyWith(color: slateColor),
            ),
            TextButton(
              onPressed: onEditClicked,
              style: TextButton.styleFrom(
                textStyle: TextTheme.of(
                  context,
                ).labelSmall?.copyWith(fontWeight: .bold),
              ),
              child: Text('Editar'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: .spaceEvenly,
          children: [
            RichText(
              textAlign: .center,
              text: TextSpan(
                text: 'PRESUPUESTO\n',
                style: TextTheme.of(
                  context,
                ).labelSmall?.copyWith(color: slateColor),
                children: [
                  TextSpan(
                    text: '\$ $budget',
                    style: TextTheme.of(
                      context,
                    ).headlineSmall?.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ),
            RichText(
              textAlign: .center,
              text: TextSpan(
                text: 'GASTADO\n',
                style: TextTheme.of(
                  context,
                ).labelSmall?.copyWith(color: slateColor),
                children: [
                  TextSpan(
                    text: '\$ $spent',
                    style: TextTheme.of(
                      context,
                    ).headlineSmall?.copyWith(fontWeight: .bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget editBuild(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: slateColor.withValues(alpha: 0.1)),
      borderRadius: BorderRadius.circular(12),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
      borderRadius: BorderRadius.circular(12),
    );
    return Column(
      spacing: 15,
      children: [
        Row(
          spacing: 5,
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
              'PRESUPUESTO A GASTAR',
              style: TextTheme.of(
                context,
              ).labelSmall?.copyWith(color: slateColor),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: enabledBorder,
                  focusedBorder: focusedBorder,
                  filled: true,
                  fillColor: slateColor.withValues(alpha: 0.05),
                  focusColor: Colors.white,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: .all(20),
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: .circular(12)),
              ),
              onPressed: onSaveClicked,
              child: Text('Guardar'),
            ),
            IconButton(
              style: IconButton.styleFrom(foregroundColor: slateColor),
              onPressed: onExitClicked,
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .all(15),
      padding: .all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(14),
        boxShadow: kElevationToShadow[1],
      ),
      child: editMode ? editBuild(context) : normalBuild(context),
    );
  }
}
