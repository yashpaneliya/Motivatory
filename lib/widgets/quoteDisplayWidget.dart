import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:flutter/services.dart';

class quoteWidget extends StatefulWidget {
  final quote;
  final author;
  final likedIndex;
  const quoteWidget({Key key, this.quote, this.author, this.likedIndex})
      : super(key: key);

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
                  size: 100.0,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  widget.quote,
                  style: quoteStyle,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                alignment: Alignment.topRight,
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "- " + widget.author,
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
                icon: !quotes[widget.likedIndex]["liked"]
                    ? Icon(Icons.favorite_border)
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                onPressed: () {
                  setState(() {
                    flag = !flag;
                    quotes[widget.likedIndex]["liked"] = flag;
                    print(quotes[widget.likedIndex]["author"]);
                    print(quotes[widget.likedIndex]["liked"]);
                  });
                }),
            IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                          text:
                              " \" ${widget.quote} \" \n \t\t - ${widget.author}"))
                      .then((value) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Quote copied to clipboard")));
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

  shareScreenShotOfQuote()async{
    RenderRepaintBoundary renderRepaintBoundary=ss.currentContext.findRenderObject();
    var image = await renderRepaintBoundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    print(directory);
    var byteData = await image.toByteData(format:ImageByteFormat.png);
    var pngBytesData = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/quote.png');
    imgFile.writeAsBytes(pngBytesData);
    // final RenderBox box = context.findRenderObject();
    // Share.file(path: '$directory/quote.png',mimeType: ShareType.TYPE_FILE,title: 'Quote').share(sharePositionOrigin:
    //                                  box.localToGlobal(Offset.zero) &
    //                                      box.size);
    print(pngBytesData);
  }
}
