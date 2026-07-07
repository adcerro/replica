import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:tester/domain/entities/transaction.dart';
import 'package:tester/ui/controllers/user_controller.dart';

class TransactionModalSheet extends StatefulWidget {
  final ValueSetter<Transaction>? onSaveClicked;
  final Transaction? baseTransaction;
  const TransactionModalSheet({
    super.key,
    this.onSaveClicked,
    this.baseTransaction,
  });
  @override
  State<TransactionModalSheet> createState() => _TransactionModalSheetState();
}

class _TransactionModalSheetState extends State<TransactionModalSheet> {
  Color indicatorColor = const Color.fromARGB(255, 100, 116, 139);
  bool incomeLabelBackground = true;
  DateTime today = DateTime.now().toLocal();
  DateTime? pickedDate;
  final UserController _userController = Get.find();
  final TextEditingController transactionTextController =
      TextEditingController();
  final TextEditingController categoryTextController = TextEditingController();
  void registerTransaction({bool isExpense = true}) {
    double? ammount = double.tryParse(
      transactionTextController.text.split(' ').last,
    );
    String label = transactionTextController.text.split(' ').first;
    if (ammount == null || label.isEmpty) {
      logError('Cannot parse transaction label/value');
      transactionTextController.text = 'Formato incorrecto';
      return;
    }
    widget.onSaveClicked!(
      Transaction(
        label: label,
        userEmail: _userController.getLoggedUser()!.email,
        value: isExpense ? ammount * -1 : ammount.abs(),
        dateTime: pickedDate ?? (widget.baseTransaction?.dateTime ?? today),
        category:
            widget.baseTransaction?.category ?? categoryTextController.text,
      ),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final Color slateColor = Color.fromARGB(150, 100, 116, 139);
    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: slateColor.withValues(alpha: 0.1)),
      borderRadius: BorderRadius.circular(12),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
      borderRadius: BorderRadius.circular(12),
    );
    bool isEdit = widget.baseTransaction != null;
    return Container(
      padding: EdgeInsets.all(10),
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: .spaceAround,
          spacing: 10,
          children: [
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  isEdit ? 'Editar gasto' : 'Nuevo gasto',
                  style: TextTheme.of(
                    context,
                  ).headlineSmall?.copyWith(fontWeight: .bold),
                  textAlign: .start,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close_sharp),
                ),
              ],
            ),
            Stack(
              alignment: .bottomEnd,
              children: [
                TextField(
                  controller: transactionTextController,
                  decoration: InputDecoration(
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    hintText: isEdit
                        ? '${widget.baseTransaction!.label} ${widget.baseTransaction!.value.abs()}'
                        : 'ej. Café 8000',
                    hintStyle: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: slateColor),
                    filled: true,
                    fillColor: slateColor.withValues(alpha: .05),
                    focusColor: Colors.white,
                  ),
                  maxLines: 2,
                ),
                Container(
                  margin: EdgeInsets.only(right: 5, bottom: 5),
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: slateColor.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    icon: Text('🎤'),
                  ),
                ),
              ],
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: slateColor.withValues(alpha: .05),
                foregroundColor: slateColor,
                fixedSize: Size(.maxFinite, 40),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(14),
                  side: enabledBorder.borderSide,
                ),
              ),
              onPressed: () async {
                pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                setState(() {});
              },
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    pickedDate == null
                        ? isEdit
                              ? '${widget.baseTransaction!.dateTime.day}/'
                                    '${widget.baseTransaction!.dateTime.month}/'
                                    '${widget.baseTransaction!.dateTime.year}'
                              : '${today.day}/${today.month}/${today.year}'
                        : '${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}',
                    textAlign: .left,
                  ),
                  Icon(Icons.calendar_month),
                ],
              ),
            ),
            TabBar(
              onTap: (value) {
                if (value != 0) {
                  setState(() {
                    indicatorColor = Color(0xFF00C950);
                    incomeLabelBackground = false;
                  });
                } else {
                  setState(() {
                    indicatorColor = Color.fromARGB(255, 100, 116, 139);
                    incomeLabelBackground = true;
                  });
                }
              },
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              indicatorWeight: 0,
              dividerHeight: 0,
              indicatorSize: .tab,
              indicator: BoxDecoration(
                color: indicatorColor,
                borderRadius: BorderRadius.circular(14),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              labelStyle: TextTheme.of(
                context,
              ).labelLarge?.copyWith(fontWeight: .bold, color: Colors.white),
              tabs: [
                Tab(
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: slateColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text('💳 Gasto'),
                  ),
                ),
                Tab(
                  child: Container(
                    height: 50,
                    width: 200,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: incomeLabelBackground
                          ? slateColor.withValues(alpha: 0.1)
                          : null,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text('💚 Ingreso'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height > 700 ? 130 : 110,
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      DropdownMenuFormField<String>(
                        controller: categoryTextController,
                        hintText:
                            isEdit &&
                                widget.baseTransaction!.category.isNotEmpty
                            ? widget.baseTransaction!.category
                            : 'Categoria (Opcional)',
                        textStyle: TextTheme.of(
                          context,
                        ).bodySmall?.copyWith(color: slateColor),
                        inputDecorationTheme: InputDecorationTheme(
                          enabledBorder: enabledBorder,
                          focusedBorder: focusedBorder,
                          filled: true,
                          fillColor: slateColor.withValues(alpha: 0.1),
                          hintStyle: TextTheme.of(
                            context,
                          ).bodySmall?.copyWith(color: slateColor),
                        ),
                        width: .maxFinite,
                        showTrailingIcon: false,
                        selectOnly: true,
                        dropdownMenuEntries: List.generate(
                          _userController.getLoggedUser()!.categories.length,
                          (index) {
                            String categoryName = _userController
                                .getLoggedUser()!
                                .categories
                                .keys
                                .elementAt(index);
                            return DropdownMenuEntry(
                              value: categoryName,
                              leadingIcon: Text(
                                _userController
                                        .getLoggedUser()
                                        ?.categories[categoryName]
                                        ?.icon ??
                                    '',
                              ),
                              label: categoryName,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          fixedSize: const Size(.maxFinite, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(14),
                          ),
                        ),
                        onPressed: () {
                          registerTransaction(isExpense: true);
                        },
                        child: Text(
                          isEdit ? 'Guardar cambios' : 'Registrar gasto',
                          style: TextTheme.of(context).labelLarge?.copyWith(
                            fontWeight: .bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF00C950),
                          fixedSize: const Size(.maxFinite, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(14),
                          ),
                        ),
                        onPressed: () {
                          registerTransaction(isExpense: false);
                        },
                        child: Text(
                          isEdit ? 'Guardar cambios' : 'Registrar ingreso',
                          style: TextTheme.of(context).labelLarge?.copyWith(
                            fontWeight: .bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
