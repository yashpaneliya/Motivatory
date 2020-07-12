import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motivatory/data/quotesModel.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';

import 'Homepage.dart';

class QuoteOfParticularCategory extends StatefulWidget {
  final title;

  const QuoteOfParticularCategory({Key key, this.title}) : super(key: key);
  @override
  _QuoteOfParticularCategoryState createState() =>
      _QuoteOfParticularCategoryState();
}

class _QuoteOfParticularCategoryState extends State<QuoteOfParticularCategory> {
  List<Quote> quotesOfCategory = [];

  @override
  void initState() {
    super.initState();
  }

  //function to get quotes of a particular category
  Future<List<Quote>> getQuoteOfCategory(String category) async {
    final sql = '''SELECT * FROM ${Quotes.quoteTable} 
    WHERE Category=="$category"
    ''';

    final data = await db.rawQuery(sql);

    for (final node in data) {
      var temp = Quote.fromJson(node);
      quotesOfCategory.add(temp);
      // print(temp.author);
    }
    return quotesOfCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
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
          future: getQuoteOfCategory(widget.title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              );
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Random rand = Random();
                var temp=rand.nextInt(snapshot.data.length);
                return quoteWidget(
                  quote: snapshot.data[temp]
                );
              },
            );
          }),
    );
  }
}
