import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/providers/auth_provider.dart';
import 'package:renew_market/screens/chat_list_screen.dart';
import 'package:renew_market/screens/home_screen.dart';
import 'package:renew_market/screens/post_upload_screen.dart';
import 'package:renew_market/screens/profile_screen.dart';
import 'package:renew_market/screens/search_screen.dart';
import 'package:renew_market/screens/sign_in_screen.dart';
import 'package:renew_market/widgets/upload_mock_data_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int screenIndex = 0; // Index of selected screen
  // Screen Lst
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const PostUploadScreen(),
    const ChatListScreen(),
    // const UploadMockDataScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authPvider = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.network(logoUrl, height: 40, fit: BoxFit.contain),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Colors.grey[200],
                    content: Text(
                      "Are You Sure To Logout?",
                      style: TextStyle(fontSize: 20),
                    ),
                    actions: [
                      TextButton(
                        onPressed: Navigator.of(context).pop, // Close dialog
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await authPvider.signOut();
                          await Future.delayed(
                            Duration(milliseconds: 2000),
                            () {
                              return CircularProgressIndicator();
                            },
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.logout_rounded, size: 26),
          ),
        ],
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
