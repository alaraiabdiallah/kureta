import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';

import '../screens.dart';

class ExploreRead extends StatefulWidget {
  @override
  _ExploreRead createState() => _ExploreRead();

}

class _ExploreRead extends State<ExploreRead> {

  int _selected;

  Widget _selectorItem({String title,String imageUrl = 'https://placeimg.com/640/480/any',bool active = false, Function onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: AnimatedContainer(
          padding: EdgeInsets.fromLTRB(15,8,15,8),
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: active? Color(0xff1B7FBF) : Color(0xff3498D8),
          ),
          child: Container(
              child: Center(child: Text(title, style: TextStyle(color: Colors.white)),)
          ),
        ),
      ),
    );
  }

  Widget _categorySelectors(){
    return Container(
      width: double.infinity,
      height: 45,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(15,0,15,0),
        children: <Widget>[
          ...List.generate(10, (index){
            return _selectorItem(
                title: "Category ${(index + 1).toString()}",
                active: _selected == index,
                onTap: (){
                  setState(() => _selected = index);
                }
            );
          })

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          _categorySelectors(),
          SizedBox(height: 10),
          Expanded(
           child: Container(
             padding: const EdgeInsets.fromLTRB(15,0,8,8),
             child: ListView(
               children: <Widget>[
                 ...articleMocks2.map((article){
                   return ReadListItem(
                     title: article.title,
                     category: article.category,
                     onTap: (){
                       var readScreen = ReadScreen(title: article.title, content: article.content, category: article.category, imageUrl: article.imageUrl);
                       Navigator.push(context,
                         MaterialPageRoute(builder: (context) => readScreen),
                       );
                     },
                   );
                 }).toList()
               ],
             ),
           ),
          )
        ],
      ),
    );
  }

}