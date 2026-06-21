import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  final String title;
  final String emojiIcon;
  final List<Widget> children;
  final CrossAxisAlignment expandedCrossAxisAlignment;
  const CustomExpansionTile({
    super.key,
    this.title = '',
    this.emojiIcon = '',
    this.children = const [],
    this.expandedCrossAxisAlignment = .center,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(10),
      child: ExpansionTile(
        childrenPadding: .all(10),
        title: Text(
          title,
          style: TextTheme.of(context).bodyLarge?.copyWith(fontWeight: .bold),
        ),
        subtitle: Text(
          'Haz clic para expandir/contraer',
          style: TextTheme.of(context).bodySmall?.copyWith(color: slateColor),
        ),
        collapsedIconColor: Theme.of(context).primaryColor,
        collapsedBackgroundColor: Colors.white,
        collapsedShape: RoundedRectangleBorder(
          side: BorderSide(color: slateColor.withValues(alpha: .2)),
          borderRadius: .circular(14),
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: slateColor.withValues(alpha: .2)),
          borderRadius: .circular(14),
        ),
        leading: Container(
          decoration: BoxDecoration(
            color: slateColor.withValues(alpha: 0.1),
            borderRadius: .circular(12),
          ),
          padding: .all(5),
          child: Text(emojiIcon, style: TextTheme.of(context).headlineSmall),
        ),

        expandedCrossAxisAlignment: expandedCrossAxisAlignment,
        children: children,
      ),
    );
  }
}
