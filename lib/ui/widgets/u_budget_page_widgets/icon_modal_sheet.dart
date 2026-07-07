import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, List<String>> icons = {
  'Hogar': ['🏠', '🏡', '🛋️', '🪴', '🔧', '💡', '🚰', '🧹'],
  'Comida': ['🍔', '🍕', '🥗', '🛒', '🍽️', '☕️', '🍱', '🧃'],
  'Transporte': ['🚗', '🚌', '✈️', '🚲️', '⛽️', '🏍️', '🚇️', '🛵'],
  'Salud': ['🏥', '💊', '🩺', '🧴', '🦷', '🩹', '🧠', '🧪'],
  'Educación': ['📚', '📝', '🎓', '🖊️', '📖', '🧮', '🖍️', '🧑‍🏫'],
  'Entretenimiento': ['🎬', '🎮', '🎧', '🎨', '🎭️', '🎤', '📺️', '🎪'],
  'otros': ['💳', '💰', '🛍️', '🎁', '📦', '🧾', '🪙', '🏷️'],
};

class IconModalSheet extends StatelessWidget {
  const IconModalSheet({super.key, required this.onSelectedIcon});
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  final ValueSetter<String> onSelectedIcon;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: Text(
              'ELIGE UN ÍCONO',
              style: TextTheme.of(
                context,
              ).labelLarge?.copyWith(fontWeight: .bold, color: slateColor),
            ),
          ),
        ),
        SliverList.builder(
          itemCount: icons.length,
          itemBuilder: (context, headerIndex) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    icons.keys.elementAt(headerIndex),
                    style: TextTheme.of(context).labelLarge?.copyWith(
                      fontWeight: .bold,
                      color: slateColor,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: icons[icons.keys.elementAt(headerIndex)]!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 40,
                    ),
                    itemBuilder: (context, listIndex) => TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: slateColor.withValues(alpha: 0.05),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                      ),
                      onPressed: () {
                        onSelectedIcon(
                          icons[icons.keys.elementAt(headerIndex)]![listIndex],
                        );
                        Get.back();
                      },
                      child: Text(
                        icons[icons.keys.elementAt(headerIndex)]![listIndex],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
