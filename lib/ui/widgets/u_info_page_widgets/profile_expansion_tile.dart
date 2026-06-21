import 'package:flutter/material.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/custom_expansion_tile.dart';

class ProfileExpansionTile extends CustomExpansionTile {
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userCountry;
  final bool editMode;
  final VoidCallback? onEditClicked;
  final VoidCallback? onCancelClicked;
  final ValueSetter<Map<String, String>>? onSaveClicked;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  ProfileExpansionTile({
    super.key,
    this.userName = '',
    this.userEmail = '',
    this.userPhone = '',
    this.userCountry = '',
    this.editMode = false,
    this.onEditClicked,
    this.onCancelClicked,
    this.onSaveClicked,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? labelStyle = TextTheme.of(
      context,
    ).labelMedium?.copyWith(color: super.slateColor, fontWeight: .bold);
    InputDecoration fieldDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: super.slateColor),
        borderRadius: .circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: super.slateColor.withValues(alpha: 1)),
        borderRadius: .circular(12),
      ),
    );
    return CustomExpansionTile(
      title: 'Mi perfil',
      emojiIcon: '👤',
      expandedCrossAxisAlignment: .stretch,
      children: [
        editMode
            ? const SizedBox()
            : TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                ),
                onPressed: onEditClicked,
                child: Text('✏️ Editar'),
              ),
        const SizedBox(height: 10),
        Text('NOMBRE', style: labelStyle),
        editMode
            ? TextField(
                controller: nameController,
                decoration: fieldDecoration.copyWith(hintText: userName),
              )
            : Text(userName),
        const Divider(height: 20, thickness: 0.25),
        Text('EMAIL', style: labelStyle),
        editMode
            ? TextField(
                controller: emailController,
                decoration: fieldDecoration.copyWith(hintText: userEmail),
              )
            : Text(userEmail),
        const Divider(height: 20, thickness: 0.25),
        Text('TELÉFONO', style: labelStyle),
        editMode
            ? TextField(
                controller: phoneController,
                decoration: fieldDecoration.copyWith(hintText: userPhone),
              )
            : Text(userPhone),
        const Divider(height: 20, thickness: 0.25),
        Text('PAÍS', style: labelStyle),
        editMode
            ? TextField(
                controller: countryController,
                decoration: fieldDecoration.copyWith(hintText: userCountry),
              )
            : Text(userCountry),
        editMode
            ? const Divider(height: 20, thickness: 0.25)
            : const SizedBox(),
        Row(
          spacing: 10,
          mainAxisAlignment: .spaceAround,
          children: editMode
              ? [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: slateColor,
                        textStyle: TextTheme.of(
                          context,
                        ).labelLarge?.copyWith(fontWeight: .bold),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: slateColor),
                          borderRadius: .circular(12),
                        ),
                      ),
                      onPressed: onCancelClicked,
                      child: Text('Cancelar'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        textStyle: TextTheme.of(
                          context,
                        ).labelMedium?.copyWith(fontWeight: .bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                      ),
                      onPressed: () => onSaveClicked!({
                        'name': nameController.text,
                        'email': emailController.text,
                        'phone': phoneController.text,
                        'country': countryController.text,
                      }),
                      child: Text('✓ Guardar Cambios'),
                    ),
                  ),
                ]
              : [],
        ),
      ],
    );
  }
}
