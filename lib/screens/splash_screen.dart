import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kureta_app/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    timer = new Timer(Duration(seconds: 2), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryOnboardingScreen()));
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/kureta-logo-resized.png",width: 100,),
      ),
    );
  }
  
}