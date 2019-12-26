import 'package:flutter/material.dart';
import 'package:kureta_app/models/article.dart';

class ReadItem extends StatelessWidget {

  final String title;
  final String category;
  final String content;
  final String imageUrl;
  final Function onTap;

  final int excerptLimit;

  ReadItem({Key key,
    @required this.title,
    @required this.category,
    @required this.content,
    this.imageUrl = "https://placeimg.com/640/480/any",
    this.excerptLimit = 50,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var radius = Radius.circular(3);
    Widget _imageSection(){
      return GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
          child: Image.network(imageUrl),
        ),
      );
    }

    bool isReadMore(){
      return content.length > excerptLimit;
    }

    String excerptText(){
      return isReadMore() ? content.substring(0,excerptLimit) + "..." : content;
    }

    Widget _secondarySection(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(category, style: TextStyle(fontSize: 16),),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.share,color: Colors.black),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border,color: Colors.black,),
                onPressed: (){},
              ),
            ],
          )
        ],
      );
    }

    Widget _mainSection(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(excerptText(), style: TextStyle(fontSize: 18),),
                SizedBox(height: 10,),
                if(isReadMore())...[
                  Text("readmore", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ]
              ],
            ),
          )
        ],
      );
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _imageSection(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _secondarySection(),
                _mainSection()
              ],
            ),
          )

        ],
      ),
    );
  }
}

class ReadListItem extends StatelessWidget {

  final String title;
  final String category;
  final String imageUrl;
  final Function onTap;


  ReadListItem({Key key,
    @required this.title,
    @required this.category,
    this.imageUrl = "https://placeimg.com/640/480/any",
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0,15,10,0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff3498D8),
                      image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover
                      ),
                  ),
                ),
              ),
              Container(
                  width: 230,
                  margin: EdgeInsets.fromLTRB(0,15,0,0),
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if(category != null)...[
                        Text(category, style: Theme.of(context).textTheme.subtitle.copyWith(fontWeight: FontWeight.normal, fontSize: 13))
                      ],
                      SizedBox(height: 3,),
                      Text(title, maxLines: 3, style: Theme.of(context).textTheme.title.copyWith(fontSize: 16)),
                    ],
                  ),
              ),
            ],
          ),
      ),
    );
  }
}

class ReadCarousel extends StatefulWidget{

  final Function onItemTap;
  final List<Article> articles;

  const ReadCarousel({Key key, this.onItemTap, this.articles}) : super(key: key);

  @override
  _ReadCarousel createState() => _ReadCarousel();

}

class _ReadCarousel extends State<ReadCarousel>{

  PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      viewportFraction: 0.9,
    );
    _pageController.addListener((){
      int next = _pageController.page.round();
      if(_currentPage != next)
        setState(() => _currentPage = next);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          return ReadCarouselItem(
            title: widget.articles[index].title,
            category: widget.articles[index].category,
            imageUrl: widget.articles[index].imageUrl,
            active: index == _currentPage,
            onTap: () {
              widget.onItemTap(widget.articles[index]);
            },
          );
        }),
    );
  }

}

class ReadCarouselItem extends StatelessWidget {

  final String title;
  final bool active;
  final String category;
  final String imageUrl;
  final Function onTap;

  const ReadCarouselItem({Key key, this.title, this.category, this.imageUrl = 'https://placeimg.com/640/480/any', this.active, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topbot = active? 20:40;
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover
            ),
            color: Color(0xff3498D8),
            borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.only(top:topbot, bottom: topbot, left: 10, right: 10),
        child: GestureDetector(
          onTap: onTap,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10,15,10,15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(category, style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white, fontWeight: FontWeight.normal)),
                    SizedBox(height: 2,),
                    Text(title, style: Theme.of(context).textTheme.title.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}
