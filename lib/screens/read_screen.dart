import 'package:flutter/material.dart';

class ReadScreen extends StatefulWidget {

  final String title;
  final String content;
  final String imageUrl;

  const ReadScreen({Key key, @required this.title, @required this.content, this.imageUrl = 'https://placeimg.com/640/480/any'}) : super(key: key);

  @override
  _ReadScreen createState() => _ReadScreen();
}

class _ReadScreen extends State<ReadScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(widget.title),
            expandedHeight: 200.0,
          floating: true,
            pinned: true,
            primary: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(widget.imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: Text(widget.content, style: TextStyle(fontSize: 18),),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.share),
              title: Text("Reading")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              title: Text("Search")
          )
        ],
      ),
    );
  }

}