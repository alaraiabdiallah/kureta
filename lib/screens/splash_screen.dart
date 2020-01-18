import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen> {
  SavedCategorySource _scs = SavedCategorySource();

  @override
  void initState() {
    _scs.getAll().then((data){
      List categories = data;
      if(categories.length > 0)
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
      else
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryOnboardingScreen()));
    });
    super.initState();
  }

  @override
  void dispose() {
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