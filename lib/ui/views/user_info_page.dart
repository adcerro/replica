import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/data_expansion_tile.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/legal_expansion_tile.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/profile_expansion_tile.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/security_expansion_tile.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/settings_expansion_tile.dart';

import '../../domain/entities/user.dart';
import '../widgets/gradient_bakground.dart';
import '../widgets/u_info_page_widgets/picture_expansion_tile.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final UserController _userController = Get.find();
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  bool editUser = false;
  @override
  Widget build(BuildContext context) {
    User? user = _userController.getLoggedUser();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          collapsedHeight: 200,
          flexibleSpace: GradientBackground(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 16, 15, 25),
              child: Column(
                spacing: 10,
                mainAxisAlignment: .center,
                children: [
                  Container(
                    foregroundDecoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(width: 3, color: Colors.white70),
                      ),
                    ),
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(width: 3, color: Colors.white70),
                      ),
                    ),
                    clipBehavior: .antiAlias,
                    child: Image.asset('assets/intranquilo.png', height: 50),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user!.name!.capitalize ?? '',
                    style: TextTheme.of(context).titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextTheme.of(
                      context,
                    ).titleSmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(
          child: ProfileExpansionTile(
            userName: user.name!.capitalize ?? '',
            userEmail: user.email,
            userPhone: '+57 --- --- ----',
            userCountry: 'Colombia',
            editMode: editUser,
            onEditClicked: () => setState(() => editUser = true),
            onCancelClicked: () => setState(() => editUser = false),
            onSaveClicked: (value) {
              setState(() {
                editUser = false;
              });
            },
          ),
        ),
        SliverToBoxAdapter(child: PictureExpansionTile()),
        SliverToBoxAdapter(child: SecurityExpansionTile()),
        SliverToBoxAdapter(child: DataExpansionTile()),
        SliverToBoxAdapter(child: SettingsExpansionTile()),
        SliverToBoxAdapter(child: LegalExpansionTile()),
        const SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(
          child: Padding(
            padding: .all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: .circular(12)),
              ),

              onPressed: () {},
              child: Text('Cerrar Sesión'),
            ),
          ),
        ),
      ],
    );
  }
}
