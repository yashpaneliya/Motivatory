import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:motivatory/Screens/quotesOfCategory.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:motivatory/resources/styles.dart';

class CategoryCard extends StatefulWidget {
  final icon;
  final categoryTitle;

  const CategoryCard({Key key, this.icon, this.categoryTitle})
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
        margin: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: catcolor,
            boxShadow: [
              BoxShadow(
                  color: catTabBackColors.elementAt(Random().nextInt(7)),
                  offset: Offset(-5, 0))
            ],
            border: Border.all(color: catcolor, width: 5.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                widget.icon,
                size: 50.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              alignment: Alignment.bottomRight,
              child: Text(
                widget.categoryTitle,
                style: catTitleStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
