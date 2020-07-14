import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motivatory/Screens/quotesOfCategory.dart';
import 'package:motivatory/resources/colors.dart';

class CategoryCard extends StatefulWidget {

  final categoryTitle;

  const CategoryCard({Key key, this.categoryTitle})
      : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>QuoteOfParticularCategory(title:widget.categoryTitle)));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: catcolor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(1, 0),blurRadius: 10.0)
            ],
            border: Border.all(color: catcolor, width: 5.0),
            borderRadius: BorderRadius.circular(5.0)),
        child: Container(
              margin: EdgeInsets.only(top:25.0,bottom: 25.0),
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child: Text(
                widget.categoryTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, letterSpacing: 1.0,color: catTabBackColors[Random().nextInt(10)]),
              ),
            ),
      ),
    );
  }
}
