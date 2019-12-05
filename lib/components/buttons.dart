import 'package:flutter/material.dart';

class KuretaButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double width;
  final Color color;

  const KuretaButton({Key key, this.onPressed, @required this.text, this.width = double.infinity, this.color = const Color(0xff3498D8)}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: this.width,
      child: RaisedButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: Colors.white,
        hoverColor: this.color,
        color: this.color,
        disabledColor: this.color,
        child: Text(this.text,style: TextStyle(color: Colors.white),),
      ),
    );
  }

}