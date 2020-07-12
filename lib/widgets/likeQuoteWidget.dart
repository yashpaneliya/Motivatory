import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:motivatory/Screens/likedQuotes.dart';
import 'package:motivatory/data/likeModel.dart';
import 'package:motivatory/data/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:flutter/services.dart';

class likedQuoteWidget extends StatefulWidget {
  final LikedQuote quote;

  const likedQuoteWidget({Key key, this.quote}) : super(key: key);

  @override
  _likedQuoteWidgetState createState() => _likedQuoteWidgetState();
}

class _likedQuoteWidgetState extends State<likedQuoteWidget> {
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
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  deleteLikedQuote(widget.quote).then((value) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Unliked"),
                      duration: Duration(seconds: 1),
                    ));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LikedQuotesPage()));
                  });
                    
                }),
            IconButton(
                icon: Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                          text:
                              " \" ${widget.quote.quoteText.toString()} \" \n \t\t - ${widget.quote.author.toString()}"))
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
    // final RenderBox box = context.findRenderObject();
    // Share.file(path: '$directory/quote.png',mimeType: ShareType.TYPE_FILE,title: 'Quote').share(sharePositionOrigin:
    //                                  box.localToGlobal(Offset.zero) &
    //                                      box.size);
    print(pngBytesData);
  }
}
