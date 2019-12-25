import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
KuretaAppBar({BuildContext context, String title}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(75),
    child: AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 30,
              child: Image.asset("assets/images/kureta-logo.png",width: 40,),
            ),
            Positioned(
              top: 23.5,
              left: 79,
              child: Text(title, style: TextStyle( fontSize: 26),),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
//      actions: <Widget>[
//        Padding(
//          padding: const EdgeInsets.fromLTRB(0, 13,30,0),
//          child: IconButton(
//            icon: Icon(Icons.menu, color: Color(0xff3498D8), size: 40,),
//            onPressed: onOptionTapped,
//          ),
//        )
//      ],
    ),
  );
}