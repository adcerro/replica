import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';
import 'package:tester/ui/widgets/u_info_page_widgets/profile_expansion_tile.dart';

import '../../domain/entities/user.dart';
import '../widgets/gradient_bakground.dart';

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
          collapsedHeight: 190,
          flexibleSpace: GradientBackground(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 16, 15, 25),
              child: Column(
                spacing: 10,
                mainAxisAlignment: .center,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.white70),
                      ),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.bar_chart_rounded, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user!.getName()!.capitalize ?? '',
                    style: TextTheme.of(context).titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    user.getEmail(),
                    style: TextTheme.of(
                      context,
                    ).titleSmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(
          child: ProfileExpansionTile(
            userName: user.getName()!.capitalize ?? '',
            userEmail: user.getEmail(),
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
      ],
    );
  }
}
