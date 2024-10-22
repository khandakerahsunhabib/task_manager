import 'package:flutter/material.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_box),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.close),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
