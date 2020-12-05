import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashPage extends StatelessWidget {

  static const routeName = '/splash_page';

  @override
  Widget build(BuildContext context) {

    //NOTE: Redirect after several seconds
    Future.delayed(
        const Duration(seconds: 5),
            () => Navigator.pushNamed(context, HomePage.routeName)
    );

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