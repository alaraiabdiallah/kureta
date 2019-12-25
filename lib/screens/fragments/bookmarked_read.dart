import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import '../screens.dart';

class BookmarkedRead extends StatefulWidget {
  @override
  _BookmarkedRead createState() => _BookmarkedRead();

}

class _BookmarkedRead extends State<BookmarkedRead> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25,10,25,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...articleMocks.map((article){
                return ReadItem(
                  title: article.title,
                  category: article.category,
                  content: article.excerpt,
                  onTap: (){
                    var readScreen = ReadScreen(title: article.title, content: article.content, category: article.category, imageUrl: article.imageUrl);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => readScreen),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        )

      ],
    );
  }

}