import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import '../screens.dart';

class Setting extends StatefulWidget {
  @override
  _Setting createState() => _Setting();

}

class _Setting extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25,10,25,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Notification", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),

            ],
          ),
        )

      ],
    );
  }

}