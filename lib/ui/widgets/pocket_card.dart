import 'package:flutter/material.dart';

class PocketCard extends StatelessWidget {
  final Color foregroundColor;
  final String emojiIcon;
  final String title;
  final double spent;
  final double budget;
  final double completion;
  final bool hideAmmounts;
  const PocketCard({
    super.key,
    required this.foregroundColor,
    this.emojiIcon = '',
    required this.title,
    required this.spent,
    required this.budget,
    required this.completion,
    this.hideAmmounts = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: .fromLTRB(top: BorderSide(width: 2, color: foregroundColor)),
        borderRadius: BorderRadius.circular(14),
        boxShadow: kElevationToShadow[1],
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: foregroundColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(5),
                child: Text(
                  emojiIcon,
                  style: TextTheme.of(context).headlineSmall,
                ),
              ),
              Text(
                title,
                style: TextTheme.of(
                  context,
                ).labelLarge?.copyWith(fontWeight: .bold),
              ),
            ],
          ),
          Text.rich(
            style: TextTheme.of(context).bodyMedium,
            TextSpan(
              text: hideAmmounts ? '****' : '\$ $spent',
              style: TextStyle(fontWeight: .bold),
              children: [
                TextSpan(
                  text: hideAmmounts ? '' : ' / \$ $budget',
                  style: TextStyle(fontWeight: .normal),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: completion,
            borderRadius: BorderRadius.circular(12),
            minHeight: 10,
            backgroundColor: Color.fromARGB(40, 100, 116, 139),
          ),
        ],
      ),
    );
  }
}
