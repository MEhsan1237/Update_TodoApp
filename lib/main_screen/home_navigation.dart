
import 'package:flutter/material.dart';
import 'package:todo_app/main_screen/dashboard_screen.dart';
import 'package:todo_app/main_screen/main_screen.dart';
import 'package:provider/provider.dart';
import '../provider/provider_class.dart';
import '../functions/showdialouge_fun.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key});

  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const MyAppHive(), // This is the existing Todo list screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_rounded),
              label: 'Tasks',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMyDialogue(context),
        shape: const CircleBorder(),
        elevation: 8,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
