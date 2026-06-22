import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/custom_expansion_tile.dart';

class SettingsExpansionTile extends CustomExpansionTile {
  const SettingsExpansionTile({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(title: 'Preferencias', emojiIcon: '⚙️');
  }
}
