import 'package:flutter/material.dart';
import 'package:motivatory/data/categoryData.dart';
import 'package:motivatory/data/quotesModel.dart';
import 'package:motivatory/widgets/categoryCard.dart';

import 'Homepage.dart';

List<CategoryModel> categoryList = [];

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  getAllCategories() async {
    categoryList = [];
    final sql =
        '''SELECT DISTINCT ${Quotes.category} FROM ${Quotes.quoteTable}''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      var temp = CategoryModel.fromJson(node);
      categoryList.add(temp);
    }
    return categoryList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: CatSearch(categoryList));
              })
        ],
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
            return ListView.builder(
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoryTitle: categoryList[index].categoryTitle,
                );
              },
            );
          }),
    );
  }
}

class CatSearch extends SearchDelegate<CategoryModel> {
  final List<CategoryModel> categories;

  CatSearch(this.categories)
      : super(
          searchFieldLabel: "Search Category",
          searchFieldStyle: TextStyle(color: Colors.black),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context).copyWith(
          // ignore: deprecated_member_use
          textTheme: TextTheme(
              title:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = categories.where((element) => element.categoryTitle
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())).toList();
    if (results.length == 0) {
      return Center(
        child: Text(
          'Category not available!!!',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return CategoryCard(
          categoryTitle: results[index].categoryTitle,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = categories.where((element) => element.categoryTitle
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase())).toList();
    if (results.length == 0) {
      return Center(
        child: Text(
          'Category not available!!!',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      
      itemBuilder: (context, index) {
        return CategoryCard(
          categoryTitle: results[index].categoryTitle,
        );
      },
    );
  }
}
