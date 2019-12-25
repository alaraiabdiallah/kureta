import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import '../screens.dart';

class CategorizedRead extends StatefulWidget {
  @override
  _CategorizedRead createState() => _CategorizedRead();

}

class _CategorizedRead extends State<CategorizedRead> {
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        ReadCarousel(
            articles: articleMocks,
            onItemTap: (item){
              var readScreen = ReadScreen(title: item.title, content: item.content, category: item.category, imageUrl: item.imageUrl);
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => readScreen),
              );
            }
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(25,10,25,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Technology", style: Theme.of(context).textTheme.title),
              Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        ...articleMocks2.map((article){
                          return ReadListItem(
                            title: article.title,
                            category: null,
                            onTap: (){
                              var readScreen = ReadScreen(title: article.title, content: article.content, category: article.category, imageUrl: article.imageUrl);
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => readScreen),
                              );
                            },
                          );
                        }).toList()
                      ],
                    )
                  ],
                ),
              ),
              Text("Traveling", style: Theme.of(context).textTheme.title),
              Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        ...articleMocks2.map((article){
                          return ReadListItem(
                            title: article.title,
                            category: null,
                            onTap: (){
                              var readScreen = ReadScreen(title: article.title, content: article.content, category: article.category, imageUrl: article.imageUrl);
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => readScreen),
                              );
                            },
                          );
                        }).toList()
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
//

      ],
    );
  }

}