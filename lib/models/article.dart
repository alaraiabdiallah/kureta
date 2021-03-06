import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String id;
  String title;
  String excerpt;
  String imageUrl;
  String content;
  String category;

  Article({this.id, this.title, this.excerpt, this.imageUrl, this.content, this.category});

  Article.fromFirebase(DocumentSnapshot doc){
    var data = doc.data;
    id = doc.documentID;
    title = data["title"];
    category = data['category'];
    excerpt = data['excerpt'];
    content = data['content'];
    imageUrl = data['imageURL'];
  }

  Article.fromLocalDB(Map<String,dynamic> data){
    id = data["id"];
    title = data["title"];
    category = data['category'];
    excerpt = data['excerpt'];
    content = data['content'];
    imageUrl = data['imageURL'];
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "category": category,
    "excerpt": excerpt,
    "content": content,
    "imageURL": imageUrl,
  };
}