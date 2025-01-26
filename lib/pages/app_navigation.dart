import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccination_tracker_app/pages/home_page.dart';
import 'package:vaccination_tracker_app/pages/my_child_page.dart';
import 'package:vaccination_tracker_app/pages/profile_page.dart';
import 'package:vaccination_tracker_app/pages/rhu_page.dart';

/**
 * TODO 
 *  
 * ! Double click to exit the app
 */

class AppNavigation extends ConsumerStatefulWidget {
  const AppNavigation({super.key});

  @override
  ConsumerState<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends ConsumerState<AppNavigation> {
  final List<Widget> screens = [
    const HomePage(),
    const RhuPage(),
    const MyChildPage(),
    const ProfilePage(),
  ];

  int selectedNavIndex = 0;

  DateTime? lastPressedTime;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: Theme(
            data: ThemeData(
                navigationBarTheme: NavigationBarThemeData(
                    backgroundColor: Colors.cyan.shade300,
                    indicatorColor: Colors.cyan,
                    labelTextStyle: WidgetStateProperty.all(const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mali',
                        fontSize: 12.0)),
                    iconTheme: WidgetStateProperty.all(
                        const IconThemeData(color: Colors.white)))),
            child: NavigationBar(
                selectedIndex: selectedNavIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedNavIndex = index;
                  });
                },
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: "Home"),
                  NavigationDestination(
                      icon: Icon(Icons.local_hospital), label: "RHU Schedule"),
                  NavigationDestination(
                      icon: Icon(Icons.child_care), label: "My Child"),
                  NavigationDestination(
                      icon: Icon(Icons.person), label: "Profile"),
                ])),
        body: IndexedStack(
          index: selectedNavIndex,
          children: screens,
        ),
      ),
    );
  }
}
