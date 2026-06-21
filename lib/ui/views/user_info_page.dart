import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/ui/controllers/user_controller.dart';

import '../widgets/gradient_bakground.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});
  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final UserController _userController = Get.find();
  final Color slateColor = const Color.fromARGB(150, 100, 116, 139);
  @override
  Widget build(BuildContext context) {
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
                    _userController.getLoggedUser()!.getName()!.capitalize ??
                        '',
                    style: TextTheme.of(context).titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    _userController.getLoggedUser()!.getEmail(),
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
          child: Padding(
            padding: .all(10),
            child: ExpansionTile(
              title: Text('Mi perfil'),
              subtitle: Text('Haz clic para expandir/contraer'),
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
                child: Text('👤', style: TextTheme.of(context).headlineSmall),
              ),
              children: [Text('a'), Text('b')],
            ),
          ),
        ),
      ],
    );
  }
}
