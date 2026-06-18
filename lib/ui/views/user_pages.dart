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
      backgroundColor: Color.fromARGB(255, 248, 250, 252),
      body: switch (_selectedIndex) {
        0 => UserMainPage(),
        4 => UserInfoPage(),
        _ => UserMainPage(),
      },
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(
          255,
          252,
          236,
          236,
        ).withValues(alpha: 0.96),
        indicatorColor: Theme.of(context).primaryColor,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextTheme.of(context).labelSmall?.copyWith(
            fontSize: MediaQuery.sizeOf(context).width < 500 ? 9 : 12,
          ),
        ),

        destinations: [
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.house),
            selectedIcon: FaIcon(FontAwesomeIcons.house, color: Colors.white),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.list),
            selectedIcon: FaIcon(FontAwesomeIcons.list, color: Colors.white),
            label: 'Movimientos',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.moneyBills),
            selectedIcon: FaIcon(
              FontAwesomeIcons.moneyBills,
              color: Colors.white,
            ),
            label: 'Presupuesto',
          ),
          NavigationDestination(
            icon: Icon(Icons.signal_cellular_alt),
            selectedIcon: Icon(Icons.signal_cellular_alt, color: Colors.white),
            label: 'Análisis',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person, color: Colors.white),
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
