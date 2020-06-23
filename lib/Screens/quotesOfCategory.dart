import 'package:flutter/material.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';

class QuoteOfParticularCategory extends StatefulWidget {
  final title;

  const QuoteOfParticularCategory({Key key, this.title}) : super(key: key);
  @override
  _QuoteOfParticularCategoryState createState() =>
      _QuoteOfParticularCategoryState();
}

class _QuoteOfParticularCategoryState extends State<QuoteOfParticularCategory> {
  List<Map<String, dynamic>> quotesOfCategory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < quotes.length; i++) {
      if (quotes[i]["category"] == widget.title) {
        quotesOfCategory.add(quotes[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: quotesOfCategory.length == 0
          ? Center(
              child: Text(
                'No quote available!!!',
                style: quoteStyle,
              ),
            )
          : PageView.builder(
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              itemCount: quotesOfCategory.length,
              itemBuilder: (context, index) {
                return quoteWidget(
                  quote: quotesOfCategory[index]["quote"],
                  author: quotesOfCategory[index]["author"],
                  likedIndex: index,
                );
              },
            ),
    );
  }
}
