import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivatory/data/authorData.dart';
import 'package:motivatory/data/database_creator.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:motivatory/widgets/authorCard.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Homepage.dart';

List<Author> authorList = [];

class AuthorList extends StatefulWidget {
  @override
  _AuthorListState createState() => _AuthorListState();
}

class _AuthorListState extends State<AuthorList> {
  loadDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "working_data.db");
    ByteData data = await rootBundle.load(join("database", "en_quotes.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);
    db = await openDatabase(path);
    return getAllAuthors();
  }

  getAllAuthors() async {
    authorList = [];
    final sql =
        '''SELECT DISTINCT ${Quotes.author} FROM ${Quotes.quoteTable}''';
    final data = await db.rawQuery(sql);
    for (final node in data) {
      var temp = Author.fromJson(node);
      authorList.add(temp);
    }
    return authorList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          'Authors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AuthorSearch(authorList),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: loadDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          }
          return ListView.builder(itemBuilder: (context, index) {
            return Authorcard(
              authorname: snapshot.data[index].name,
            );
          });
        },
      ),
    );
  }
}

class AuthorSearch extends SearchDelegate<Author> {
  final List<Author> authors;

  AuthorSearch(this.authors):super(
    searchFieldLabel: "Search author",
    searchFieldStyle:TextStyle(color: Colors.black),
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context).copyWith(
      // ignore: deprecated_member_use
      textTheme: TextTheme(title: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
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
   final results = authors
        .where((element) =>
            element.name.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0) {
      return Center(
        child: Text(
          'Author not available!!!',
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
          return Authorcard(
            authorname: results[index].name,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = authors
        .where((element) =>
            element.name.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.length == 0) {
      return Center(
        child: Text(
          'Author not available!!!',
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
          return Authorcard(
            authorname: results[index].name,
          );
        });
  }
}
