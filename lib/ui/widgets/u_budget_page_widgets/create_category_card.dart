import 'package:flutter/material.dart';

class CreateCategoryCard extends StatelessWidget {
  const CreateCategoryCard({super.key, this.onCancelPressed});
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  final VoidCallback? onCancelPressed;

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
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 200,
                        child: Center(child: Text('Selecciona un icono')),
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
                        '💳',
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
                  onPressed: () {},
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
                onPressed: onCancelPressed,
                child: Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
