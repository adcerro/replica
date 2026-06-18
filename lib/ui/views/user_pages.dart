import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tester/ui/views/user_info_page.dart';
import 'package:tester/ui/views/user_main_page.dart';

class UserPages extends StatefulWidget {
  const UserPages({super.key});
  @override
  State<UserPages> createState() => _UserPagesState();
}

class _UserPagesState extends State<UserPages> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: switch (_selectedIndex) {
        0 => UserMainPage(),
        1 => UserInfoPage(),
        _ => UserMainPage(),
      },
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).focusColor,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.house_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book),
            label: 'Movimientos',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.moneyBill),
            label: 'Presupuesto',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Análisis',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: 'Perfil',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
