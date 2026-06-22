import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/custom_expansion_tile.dart';

class PictureExpansionTile extends CustomExpansionTile {
  const PictureExpansionTile({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      title: 'Foto de Perfil',
      emojiIcon: '📸',
      expandedCrossAxisAlignment: .stretch,
      children: [
        Text(
          'FOTO ACTUAL',
          style: TextTheme.of(
            context,
          ).labelMedium?.copyWith(color: slateColor, fontWeight: .bold),
        ),
        DottedBorder(child: Image.asset('assets/intranquilo.png')),
        const Divider(height: 20, thickness: 0.25),
        Text(
          'CAMBIAR',
          style: TextTheme.of(
            context,
          ).labelMedium?.copyWith(color: slateColor, fontWeight: .bold),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          ),
          onPressed: () {},
          child: Text('Subir nueva foto'),
        ),
        const Divider(height: 20, thickness: 0.25),
        Text(
          'ELIMINAR',
          style: TextTheme.of(
            context,
          ).labelMedium?.copyWith(color: slateColor, fontWeight: .bold),
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: .circular(12)),
          ),
          onPressed: () {},
          child: Text('Remover foto'),
        ),
      ],
    );
  }
}
