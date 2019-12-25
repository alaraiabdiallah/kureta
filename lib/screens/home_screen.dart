import 'package:flutter/material.dart';
import 'package:kureta_app/components/appbars.dart';
import 'package:kureta_app/screens/fragments/categorized_read.dart';
import 'package:kureta_app/screens/fragments/bookmarked_read.dart';
import 'package:kureta_app/screens/fragments/setting.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;
  List<String> titles = ["Reads", "Bookmark", "Setting"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KuretaAppBar(context: context, title: titles[_currentIndex]),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          CategorizedRead(),
          BookmarkedRead(),
          Setting()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index){
          if(index == 2)
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text("Reads")
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