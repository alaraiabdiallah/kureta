import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import 'package:kureta_app/models/article.dart';
import '../screens.dart';

class CategorizedRead extends StatefulWidget {
  @override
  _CategorizedRead createState() => _CategorizedRead();

}

class _CategorizedRead extends State<CategorizedRead> {

  @override
  void initState() {
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {

    _buildHeadlineArticle(){
      return StreamBuilder(
          stream: Firestore.instance.collection('articles').limit(10).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
              default:
                if(snapshot.data.documents.length < 1)
                  return Container();
                snapshot.data.documents.shuffle();
                return ReadCarousel(
                    articles: snapshot.data.documents.map((doc) => Article.fromFirebase(doc)).toList(),
                    onItemTap: (Article item){
                      print(item.title);
                      var readScreen = ReadScreen(title: item.title, content: item.content, category: item.category, imageUrl: item.imageUrl);
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => readScreen),
                      );
                    }
                );
            }
          }
      );
    }

    _buildCategoryArticleItem(String category, List<Article> catArticle){
      catArticle.shuffle();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(category, style: Theme.of(context).textTheme.title),
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
                    ...catArticle.map((article){
                      return ReadListItem(
                        title: article.title,
                        category: null,
                        imageUrl: article.imageUrl,
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
      );
    }

    _buildCategoryArticleList(){
      return StreamBuilder(
          stream: Firestore.instance.collection('articles').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            switch (snapshot.connectionState) {
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
              default:
                if(snapshot.data.documents.length < 1) return Container();
                List<Article> articles = snapshot.data.documents
                                          .map((doc) => Article.fromFirebase(doc)).toList();
                return Container(
                  padding: const EdgeInsets.fromLTRB(25,10,25,10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...categoriesMock.map((category){
                        List<Article> catCategory = articles.where((a) => a.category == category).toList();
                        if(catCategory.length < 1) return Container();
                        return _buildCategoryArticleItem(category, catCategory);
                      })
                    ],
                  ),
                );
            }

          }
      );
    }

    return ListView(
      children: <Widget>[
        _buildHeadlineArticle(),
        _buildCategoryArticleList()
      ],
    );
  }

}