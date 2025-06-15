import 'package:flutter/material.dart';
import 'package:renew_market/providers/post_provider.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:renew_market/screens/navigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/screens/sign_in_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
