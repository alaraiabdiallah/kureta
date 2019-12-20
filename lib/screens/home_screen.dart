import 'package:flutter/material.dart';
import 'package:kureta_app/components/appbars.dart';
import 'package:kureta_app/components/reads.dart';
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
                ...[1,2,3,4,5,6].map((i){
                  return ReadItem(
                    title: "Some title ${i.toString()}",
                    category: "Some category",
                    content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse congue lectus non tellus tincidunt, bibendum convallis lorem mattis.",
                    onTap: (){
                      print("News ${i.toString()} Tapped!");
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