import 'package:flutter/material.dart';
import 'package:kureta_app/components/appbars.dart';
import 'package:kureta_app/components/reads.dart';
import 'package:kureta_app/data_sources/mocks.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KuretaAppBar(context: context, onOptionTapped: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(25,10,25,10),
            child: Column(
              children: <Widget>[
                ...articleMocks.map((article){
                  return ReadItem(
                    title: article.title,
                    category: article.category,
                    content: article.excerpt,
                    onTap: (){
                      var readScreen = ReadScreen(title: article.title, content: article.content, imageUrl: article.imageUrl);
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("List")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text("Reading")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search")
          )
        ],
      ),
    );
  }

}