import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/widgets/category_menu_map.dart';

class TransactionModalSheet extends StatefulWidget {
  const TransactionModalSheet({super.key});
  @override
  State<TransactionModalSheet> createState() => _TransactionModalSheetState();
}

class _TransactionModalSheetState extends State<TransactionModalSheet> {
  Color indicatorColor = Color.fromARGB(255, 100, 116, 139);
  bool incomeLabelBackground = true;
  DateTime today = DateTime.now().toLocal();
  DateTime? pickedDate;

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
                  'Nuevo gasto',
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
                  decoration: InputDecoration(
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    hintText: 'ej. Café 8000',
                    hintStyle: TextTheme.of(
                      context,
                    ).bodyMedium?.copyWith(color: slateColor),
                    filled: true,
                    fillColor: slateColor.withValues(alpha: .05),
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

            defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: slateColor.withValues(alpha: .05),
                      foregroundColor: slateColor,
                      fixedSize: Size(420, 20),
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
                    },
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          '${today.day}/${today.month}/${today.year}',
                          textAlign: .left,
                        ),
                        Icon(Icons.calendar_month),
                      ],
                    ),
                  )
                : InputDecorationTheme(
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    filled: true,
                    fillColor: slateColor.withValues(alpha: .05),
                    child: InputDatePickerFormField(
                      fieldLabelText: '',
                      initialDate: DateTime.now().toLocal(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
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
              height: 130,
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      DropdownMenuFormField<String>(
                        hintText: 'Categoria (Opcional)',
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
                        width: 400,
                        showTrailingIcon: false,
                        selectOnly: true,
                        dropdownMenuEntries: List.generate(
                          10,
                          ((index) => DropdownMenuEntry(
                            value: CategoryMenuMap().map.keys.elementAt(index),
                            label:
                                '${CategoryMenuMap().map.values.elementAt(index)} ${CategoryMenuMap().map.keys.elementAt(index)}',
                          )),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          fixedSize: Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(14),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Registrar gasto',
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
                          fixedSize: Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: .circular(14),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Registrar ingreso',
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
