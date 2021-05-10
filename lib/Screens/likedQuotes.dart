import 'package:flutter/material.dart';
import 'package:motivatory/data/likeModel.dart';
import 'package:motivatory/data/repository.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:motivatory/widgets/likeQuoteWidget.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';

class LikedQuotesPage extends StatefulWidget {
  @override
  _LikedQuotesPageState createState() => _LikedQuotesPageState();
}

class _LikedQuotesPageState extends State<LikedQuotesPage> {
  Future<List<LikedQuote>> likelist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          "Liked Quotes",
//          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
//        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: getAllLikeQuotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
            if (snapshot.data.length==0) {
              return Center(
                child: Text(
                  'You haven\'t liked any quote!!!',
                  style: TextStyle(
//                      color: Colors.white,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
              return likedQuoteWidget(
                quote: snapshot.data[index],
              );
            });
          }),
    );
  }
}
