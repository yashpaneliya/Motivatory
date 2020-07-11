import 'package:flutter/material.dart';
import 'package:motivatory/data/categoryData.dart';
import 'package:motivatory/data/database_creator.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/widgets/categoryCard.dart';
import 'package:sqflite/sqlite_api.dart';

import 'Homepage.dart';

List<dynamic> categoryList = [];
// Database db;

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  getAllCategories() async {
    categoryList = [];
    final sql = '''SELECT DISTINCT ${Quotes.category} FROM ${Quotes.quoteTable}''';
    final data = await db.rawQuery(sql);
    print(data);
    for (final node in data) {
      var temp = node["${Quotes.category}"];
      categoryList.add(temp);
    }
    print(categoryList.length);
    return categoryList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FutureBuilder(
          future: getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
            return GridView.builder(
              // itemCount: 2,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return CategoryCard(
                  icon: Icons.sentiment_satisfied,
                  categoryTitle: categoryList[index],
                );
              },
            );
          }),
    );
  }
}
