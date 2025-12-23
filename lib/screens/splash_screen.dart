import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:renew_market/constatns/app_theme.dart';
import 'package:renew_market/constatns/urls.dart';
import 'package:renew_market/screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'animation': boxAnimation,
      'title': "Do you have items \nyou no longer use?",
    },
    {
      'animation': boxAnimation,
      'title': "Do you want to buy \nwhat you need secondhand?",
    },
    {
      'animation': mapAnimation,
      'title': 'Exchange them \nwith a new neighbor!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      _pages[index]["animation"],
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      _pages[index]["title"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 12.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? Colors.green
                                    : Colors.grey,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          //Page Indicator
          //Button
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black38, width: 1)),
        ),
        child: BottomAppBar(
          child:
              _currentPage == (_pages.length - 1)
                  ? TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: Text(
                      "Get Start",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
        ),
      ),
    );
  }
}
