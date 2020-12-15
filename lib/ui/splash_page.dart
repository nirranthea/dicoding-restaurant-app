import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashPage extends StatefulWidget {

  static const routeName = '/splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    //NOTE: Redirect after several seconds
    Future.delayed(
        const Duration(seconds: 3),
            () => Navigator.pushReplacementNamed(context,
            HomePage.routeName)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bon_logo.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}