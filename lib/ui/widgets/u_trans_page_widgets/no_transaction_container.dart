import 'package:flutter/material.dart';

class NoTransactionContainer extends StatelessWidget {
  final VoidCallback? onCreate;
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  const NoTransactionContainer({super.key, this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text('📋', style: TextTheme.of(context).headlineSmall),
          ),
          Text(
            'Aún no hay movimientos',
            style: TextTheme.of(
              context,
            ).labelLarge?.copyWith(color: slateColor),
          ),
          TextButton(
            onPressed: onCreate,
            child: Text(
              'Agregar el primero',
              style: TextTheme.of(context).labelLarge?.copyWith(
                fontWeight: .bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
