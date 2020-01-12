import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/models/article.dart';


class ReadScreen extends StatefulWidget {

  final Article article;

  const ReadScreen({Key key, @required this.article}) : super(key: key);

  @override
  _ReadScreen createState() => _ReadScreen();
}

class _ReadScreen extends State<ReadScreen> {

  ScrollController _scrollController = new ScrollController();
  Widget _titleAppbar;

  bool _isBookmarked = false;

  BookmarkSource bs = BookmarkSource();

  final double _expandedHeight = 225;

  _scrollListener(){
    setState(() =>
      _titleAppbar = _scrollController.offset > (_expandedHeight - 25) ? Text(widget.article.title): null
    );

  }

  toggleBookmark() async{
    bool isBookmarked = await bs.isBookmarked(widget.article.id);
    setState(() => _isBookmarked = isBookmarked);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    toggleBookmark();
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
              background: Image.network(widget.article.imageUrl, fit: BoxFit.cover),
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
                      Text(widget.article.category, style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black.withOpacity(0.8)),),
                      SizedBox(height: 4,),
                      Text(widget.article.title, style: Theme.of(context).textTheme.title.copyWith(color: Colors.black,fontSize: 25),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: Html(
                      data:widget.article.content,
                      defaultTextStyle: TextStyle(fontSize: 17),
                      customTextAlign: (dom.Node node) {
                         if (node is dom.Element) {
                          switch (node.localName) {
                            case "p":
                             return TextAlign.justify;
                         }
                        }
                      },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
        onPressed: ()async {
          await bs.toggle(widget.article);
          await toggleBookmark();
        },
      ),
    );
  }

}