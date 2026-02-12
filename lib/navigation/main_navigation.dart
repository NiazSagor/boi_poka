import 'package:boi_poka/explore/screen/explore_screen.dart';
import 'package:boi_poka/home/screen/home_screen.dart';
import 'package:boi_poka/my_books/my_collection_grid.dart';
import 'package:boi_poka/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;

  // Screens list
  final List<Widget> _screens = [
    const HomeScreen(), // The home content we built
    ExploreScreen(), // Placeholder
    const Center(child: Text("Post Book")),    // Placeholder
    const MyCollection(),     // Placeholder
    const Center(child: Text("Profile")),      // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: BoipokaTheme.primaryGreen,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Explore"),
              BottomNavigationBarItem(
                  icon: CircleAvatar(
                    backgroundColor: BoipokaTheme.primaryGreen,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                  label: "Post"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.swap_horiz_rounded), label: "Requests"),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
