import 'package:flutter/material.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/screens/chat_list_screen.dart';
import 'package:renew_market/screens/home_screen.dart';
import 'package:renew_market/screens/post_upload_screen.dart';
import 'package:renew_market/screens/profile_screen.dart';
import 'package:renew_market/screens/search_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int screenIndex = 0; // Index of selected screen
  // Screen Lst
  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    PostUploadScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.network(logoUrl, height: 40, fit: BoxFit.contain),
        centerTitle: true,
      ),
      body: SafeArea(child: screens.elementAt(screenIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add_outlined), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        selectedItemColor: primary,
        // unselectedItemColor: inActive,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
