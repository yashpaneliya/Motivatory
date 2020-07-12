import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motivatory/Screens/quotesOfAuhtor.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:motivatory/resources/styles.dart';

class Authorcard extends StatefulWidget {
  final authorname;

  const Authorcard({Key key, this.authorname}) : super(key: key);
  @override
  _AuthorcardState createState() => _AuthorcardState();
}

class _AuthorcardState extends State<Authorcard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOfAuthor(authorname:widget.authorname)));
      },
          child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: catcolor,
          boxShadow: [BoxShadow(color: Colors.white30,offset: Offset(2, 2))],
          border: Border.all(color: Colors.white30,width: 2.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Text(widget.authorname,style: authStyle,),
      ),
    );
  }
}
