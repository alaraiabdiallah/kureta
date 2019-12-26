import 'package:flutter/material.dart';
import 'package:kureta_app/components/appbars.dart';
import 'package:kureta_app/screens/fragments/categorized_read.dart';
import 'package:kureta_app/screens/fragments/bookmarked_read.dart';
import 'package:kureta_app/screens/fragments/explore_read.dart';
import 'package:kureta_app/screens/fragments/setting.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  List<String> titles = ["For you", "Explore", "Bookmark", "Setting"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KuretaAppBar(context: context, title: titles[_currentIndex]),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          CategorizedRead(),
          ExploreRead(),
          BookmarkedRead(),
          Setting()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black38,
        selectedItemColor: Color(0xff3498D8),
        currentIndex: _currentIndex,
        onTap: (index){
          if(index == 3)
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text("For you")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text("Saved")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Setting"),
          )
        ],
      ),
    );
  }

}