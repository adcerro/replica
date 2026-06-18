import 'package:flutter/material.dart';
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
        destinations: [
          NavigationDestination(icon: Icon(Icons.abc), label: ''),
          NavigationDestination(icon: Icon(Icons.person), label: ''),
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
