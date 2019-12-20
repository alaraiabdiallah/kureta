import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadItem extends StatelessWidget {

  final String title;
  final String category;
  final String content;
  final String imageUrl;
  final Function onTap;

  final int excerptLimit;

  ReadItem({Key key, @required this.title, @required this.category, @required this.content, this.imageUrl = "https://placeimg.com/640/480/any", this.excerptLimit = 50, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = Radius.circular(3);
    Widget _imageSection(){
      return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
          child: Image.network(imageUrl),
        ),
      );
    }

    bool isReadMore(){
      return content.length > excerptLimit;
    }

    String excerptText(){
      return isReadMore() ? content.substring(0,excerptLimit) + "..." : content;
    }

    Widget _secondarySection(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(category, style: TextStyle(fontSize: 16),),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.share,color: Colors.black),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border,color: Colors.black,),
                onPressed: (){},
              ),
            ],
          )
        ],
      );
    }

    Widget _mainSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(excerptText(), style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                if(isReadMore())...[
                  Text("readmore", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ]
              ],
            ),
          )
        ],
      );
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _imageSection(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _secondarySection(),
                _mainSection()
              ],
            ),
          )

        ],
      ),
    );
  }

}