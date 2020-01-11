import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    SavedCategorySource().getAll().then((data){
      List categories = data;
      if(categories.length > 0)
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      else
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryOnboardingScreen()));
    });
//    _timer = new Timer(Duration(seconds: 2), () async {
//
//    });
    super.initState();
  }

  @override
  void dispose() {
//    _timer.cancel();
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