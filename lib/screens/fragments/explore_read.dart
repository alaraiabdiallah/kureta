import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import 'package:kureta_app/models/article.dart';

import '../screens.dart';

class ExploreRead extends StatefulWidget {
  @override
  _ExploreRead createState() => _ExploreRead();

}

class _ExploreRead extends State<ExploreRead> {

  String _selected = categoriesMock[0];

  Widget _selectorItem({String title,String imageUrl = 'https://placeimg.com/640/480/any',bool active = false, Function onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
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
          ...categoriesMock.map((category){
            return _selectorItem(
                title: category,
                active: _selected == category,
                onTap: (){
                  setState(() => _selected = category);
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
             child: StreamBuilder(
               stream: Firestore.instance.collection('articles').where("category",isEqualTo: _selected).snapshots(),
               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
                  default:
                    if(snapshot.data.documents.length < 1) return Center(child: Text("Tidak ada article yang dapat ditampilkan."),);
                    List<Article> articles = snapshot.data.documents.map((doc) => Article.fromFirebase(doc)).toList();
                    return ListView(
                      children: <Widget>[
                        ...articles.map((article){
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
                        }).toList()
                      ],
                    );
                }

               }
             ),
           ),
          )
        ],
      ),
    );
  }

}