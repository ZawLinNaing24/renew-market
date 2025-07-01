import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renew_market/firebase_options.dart';
import 'package:renew_market/providers/auth_provider.dart';
import 'package:renew_market/providers/post_provider.dart';
import 'package:renew_market/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:renew_market/screens/navigation_screen.dart';
import 'package:renew_market/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    debugPrint("AuthStateChange => ${authProvider.authStateChange}");
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: authProvider.authStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading icon (စက်ဝိုင်း) ကိုပြထားပါ။ ဒါက user experience
            // ကောင်းဖို့အတွက် အရမ်းအရေးကြီးပါတယ်။ Login Screen ကို ခဏလေးပေါ်လာပြီးမှ
            // Home Screen ကိုရောက်သွားတာမျိုး (flicker) မဖြစ်အောင် ကာကွယ်ပေးပါတယ်။
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var user = snapshot.data;
            debugPrint("Snapshot user data $user");
            return const NavigationScreen();
          } else {
            return const SignInScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
