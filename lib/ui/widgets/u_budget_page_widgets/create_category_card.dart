import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tester/ui/widgets/u_budget_page_widgets/icon_modal_sheet.dart';

class CreateCategoryCard extends StatefulWidget {
  const CreateCategoryCard({
    super.key,
    this.onCancelPressed,
    this.onAddCategory,
  });

  final VoidCallback? onCancelPressed;
  final ValueSetter<Map<String, String>>? onAddCategory;

  @override
  State<StatefulWidget> createState() => _CreateCategoryCardState();
}

class _CreateCategoryCardState extends State<CreateCategoryCard> {
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  String selectedIcon = '💳';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: slateColor.withValues(alpha: 0.1)),
      borderRadius: BorderRadius.circular(12),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
      borderRadius: BorderRadius.circular(12),
    );
    return Container(
      margin: .symmetric(horizontal: 15),
      padding: .all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(14),
        boxShadow: kElevationToShadow[1],
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .stretch,
        children: [
          Text(
            'NUEVO BOLSILLO',
            style: TextTheme.of(
              context,
            ).labelSmall?.copyWith(color: slateColor, fontWeight: .bold),
          ),
          Row(
            spacing: 10,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: slateColor.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  fixedSize: Size(45, 45),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return IconModalSheet(
                        onSelectedIcon: (value) {
                          setState(() {
                            selectedIcon = value;
                          });
                        },
                      );
                    },
                  );
                },
                child: Stack(
                  clipBehavior: .none,
                  alignment: .bottomEnd,
                  children: [
                    Center(
                      child: Text(
                        selectedIcon,
                        style: TextTheme.of(context).headlineSmall,
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 30,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 10,
                        child: Text(
                          '✎',
                          style: TextTheme.of(
                            context,
                          ).labelSmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nombre (ej. Transporte)',
                    hintStyle: TextTheme.of(context).labelLarge,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    filled: true,
                    fillColor: slateColor.withValues(alpha: 0.05),
                    focusColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: 'Presupuesto (ej. 4000)',
              hintStyle: TextTheme.of(context).labelLarge,
              enabledBorder: enabledBorder,
              focusedBorder: focusedBorder,
              filled: true,
              fillColor: slateColor.withValues(alpha: 0.05),
              focusColor: Colors.white,
            ),
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  ),
                  onPressed: () {
                    widget.onAddCategory?.call({
                      'icon': selectedIcon,
                      'name': _nameController.text,
                      'budget': _budgetController.text,
                    });
                  },
                  child: Text('Agregar'),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: slateColor,
                  textStyle: TextTheme.of(
                    context,
                  ).labelLarge?.copyWith(fontWeight: .bold),
                ),
                onPressed: widget.onCancelPressed,
                child: Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
