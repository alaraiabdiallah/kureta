import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/category_selector.dart';
import 'package:kureta_app/data_sources/local_db.dart';
import 'package:kureta_app/services/auth_service.dart';
import '../screens.dart';

class Setting extends StatefulWidget {
  final String uid;
  final AuthService authService;
  const Setting({Key key, this.uid, this.authService}) : super(key: key);
  @override
  _Setting createState() => _Setting();

}

class _Setting extends State<Setting> {

  @override
  Widget build(BuildContext context) {

    _unauthView(){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.10)
        ),
        width: double.infinity,
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Need login to edit your category", style: TextStyle(fontSize: 22), textAlign: TextAlign.center,),
            SizedBox(height: 30),
            KuretaButton(
              text: "LOGIN ACCOUNT",
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            )
          ],
        ),
      );
    }

    _authView(){
      return FutureBuilder(
          future: SavedCategorySource().getAll(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if(!snapshot.hasData || snapshot.data.length < 1) return Container();
            List<String> categories = List<String>();
            snapshot.data.forEach((d){
              categories.add(d);
            });
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CategorySelector(categories: categories),
                  SizedBox(height: 10,),
                  KuretaButton(
                    text: "Edit",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryOnboardingScreen(isEdit: true)),
                      );
                    },
                  )
                ],
              ),
            );
          }
      );
    }

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25,10,25,10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Your category", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              if(widget.uid == null)...[
                _unauthView()
              ],
              if(widget.uid != null)...[
                _authView(),
                SizedBox(height: 10,),
                KuretaButton(
                  text: "LOGOUT",
                  onPressed: (){
                    widget.authService.logout();
                  },
                )
              ]
            ],
          ),
        )

      ],
    );
  }

}