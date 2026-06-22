import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/custom_expansion_tile.dart';

class DataExpansionTile extends CustomExpansionTile {
  const DataExpansionTile({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(title: 'Datos y Cuenta', emojiIcon: '📊');
  }
}
