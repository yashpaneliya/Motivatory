import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motivatory/data/database_creator.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';

import 'Homepage.dart';

class QuotesOfAuthor extends StatefulWidget {
  final authorname;

  const QuotesOfAuthor({Key key, this.authorname}) : super(key: key);
  @override
  _QuotesOfAuthorState createState() => _QuotesOfAuthorState();
}

class _QuotesOfAuthorState extends State<QuotesOfAuthor> {
  List<Quote> quotesOfAuthor = [];
  Future<List<Quote>> getQuoteOfAuthor(String author) async {
    final sql = '''SELECT * FROM ${Quotes.quoteTable} 
    WHERE author=="$author"
    ''';

    final data = await db.rawQuery(sql);

    for (final node in data) {
      var temp = Quote.fromJson(node);
      quotesOfAuthor.add(temp);
      // print(temp.author);
    }
    return quotesOfAuthor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          widget.authorname,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: getQuoteOfAuthor(widget.authorname),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          }
          return PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Random rand = Random();
                var temp=rand.nextInt(snapshot.data.length);
                return quoteWidget(
                  quote: snapshot.data[temp].quoteText,
                  author: snapshot.data[temp].author,
                );
              },
            ); 
        },
      ),
    );
  }
}
