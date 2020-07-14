import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:motivatory/data/likeModel.dart';
import 'package:motivatory/data/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class quoteWidget extends StatefulWidget {
  final quote;

  const quoteWidget({Key key, this.quote}) : super(key: key);

  @override
  _quoteWidgetState createState() => _quoteWidgetState();
}

class _quoteWidgetState extends State<quoteWidget> {
  bool flag = false;
  var ss = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RepaintBoundary(
          key: ss,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.rotate(
                angle: pi,
                child: Icon(
                  Icons.format_quote,
                  color: Colors.white,
                  size: 95.0,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  widget.quote.quoteText.toString(),
                  style: quoteStyle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "- " + widget.quote.author.toString(),
                  style: authorStyle,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  flag?Icons.favorite:Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  setState(() {
                    flag = true;
                  });
                  LikedQuote lq = LikedQuote(
                      widget.quote.id,
                      widget.quote.quoteText,
                      widget.quote.author,
                      widget.quote.category);
                  var temp = await likeQuote(lq);
                  if (temp == 'done') {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Liked"),
                        duration: Duration(seconds: 1)));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Already Liked"),
                        duration: Duration(seconds: 1)));
                  }
                }),
            IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                          text:
                              " \" ${widget.quote.quoteText.toString()} \" \n \t\t - ${widget.quote.author.toString()}"))
                      .then((value) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Quote copied to clipboard"),
                        duration: Duration(seconds: 1)));
                  });
                }),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  shareScreenShotOfQuote();
                }),
          ],
        )
      ],
    );
  }

  shareScreenShotOfQuote() async {
    RenderRepaintBoundary renderRepaintBoundary =
        ss.currentContext.findRenderObject();
    var image = await renderRepaintBoundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    print(directory);
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    var pngBytesData = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/quote.png');
    imgFile.writeAsBytes(pngBytesData);
    final RenderBox box = context.findRenderObject();
    print(pngBytesData);
  }
}
