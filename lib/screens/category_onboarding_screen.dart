import 'package:flutter/material.dart';
import 'package:kureta_app/components/buttons.dart';
import 'package:kureta_app/components/category_selector.dart';
import 'screens.dart';

class CategoryOnboardingScreen extends StatefulWidget {
  @override
  _CategoryOnboardingScreen createState() => _CategoryOnboardingScreen();

}

class _CategoryOnboardingScreen extends State<CategoryOnboardingScreen> {
  final emailTextCtrl = TextEditingController();
  final passwordTextCtrl = TextEditingController();
  final categories = ["Technology", "Traveling", "Culinary", "Politics"];
  List<String> selectedCategories;

  onNextButtonPressed(){
   print(selectedCategories);
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => HomeScreen()),
   );
  }

  onCategorySelected(selectedData) {
    setState(() => selectedCategories = selectedData);
  }

  onLoginButtonPressed(){
    print(this.emailTextCtrl.text);
    print(this.passwordTextCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 15),
              child: Text("Select category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
          ),
          Expanded(
            flex:6,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CategorySelector(categories: categories, onSelected: onCategorySelected),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: KuretaButton(text: "Next",onPressed: onNextButtonPressed),
            ),
          ),
        ],
      ),
    );
  }

}