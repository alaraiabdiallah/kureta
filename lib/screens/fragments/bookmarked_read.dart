import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import 'package:kureta_app/models/article.dart';
import '../screens.dart';

class BookmarkedRead extends StatefulWidget {
  @override
  _BookmarkedRead createState() => _BookmarkedRead();

}

class _BookmarkedRead extends State<BookmarkedRead> {

  BookmarkSource bookmarkSource =  BookmarkSource();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: bookmarkSource.getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if(!snapshot.hasData || snapshot.data.length < 1) return Center(child: Text("Tidak ada artikel yang ditandai."),);
          return ListView(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(25,10,25,10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...snapshot.data.map((article){
                        return ReadListItem(
                          title: article.title,
                          category: article.category,
                          imageUrl: article.imageUrl,
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ReadScreen(article: article)),
                            );
                          },
                        );
                      }).toList(),
                    ],
                  )
              )

            ],
          );
        }
    );
  }

}

