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

  ScrollController _scrollController = new ScrollController();
  Widget _titleAppbar;

  final double _expandedHeight = 225;

  _scrollListener(){
    setState(() =>
      _titleAppbar = _scrollController.offset > (_expandedHeight - 25) ? Text(widget.title): null
    );

  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            title: _titleAppbar,
            expandedHeight: _expandedHeight,
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
                  padding: const EdgeInsets.fromLTRB(20,30,20,5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("category", style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black.withOpacity(0.8)),),
                      SizedBox(height: 4,),
                      Text(widget.title, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black,fontSize: 25),),
                    ],
                  ),
                ),
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