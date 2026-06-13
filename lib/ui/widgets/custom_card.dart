import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Text title;
  final Text subtitle;
  final Widget leading;
  const CustomCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.1)),
        borderRadius: BorderRadius.circular(14),
      ),
      color: Color.fromRGBO(255, 255, 255, 0.08),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            leading,
            Expanded(
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [title, subtitle],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
