import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KuretaTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;

  const KuretaTextField({Key key, @required this.title, @required this.controller, this.obscureText = false}) : super(key: key);
  @override
  _KuretaTextField createState() => _KuretaTextField();

}

class _KuretaTextField extends State<KuretaTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(widget.title, style: TextStyle(fontSize: 20),),
        SizedBox(height: 10,),
        CupertinoTextField(
          obscureText: widget.obscureText,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          controller: this.widget.controller,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(25),offset: Offset(0, 3),blurRadius: 5)
            ]
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

}