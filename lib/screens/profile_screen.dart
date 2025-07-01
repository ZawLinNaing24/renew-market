import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/widgets/profile_tabs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late Future<void> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = context.read<UserProvider>().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('An error occurred: ${snapshot.error}')),
          );
        }
        final userPvider = context.watch<UserProvider>();
        // final user = userProvider.user;
        if (userPvider.user == null) {
          return const Scaffold(body: Center(child: Text('User not found.')));
        }
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9),
                  ),
                  child: Icon(
                    Icons.person_outline_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(child: Text(userPvider.user.name!, style: title2)),
              Expanded(
                flex: 1,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: "My Sales"),
                          Tab(text: "Favorites"),
                          Tab(text: "Reviews"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            MySalesTab(),
                            FavoritesTab(),
                            ReviewsTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
