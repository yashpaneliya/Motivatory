import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivatory/Screens/categoryPage.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:motivatory/data/database_creator.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

List<Quote> quotesList = List();
Database db;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    loadDatabase();
  }

  loadDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "working_data.db");
    ByteData data = await rootBundle.load(join("database", "en_quotes.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);
    db = await openDatabase(path);
    getAllQuotes();
  }

  getAllQuotes() async {
    quotesList = [];
    final sql = '''SELECT * FROM ${Quotes.quoteTable}''';
    final data = await db.rawQuery(sql);

    for (final node in data) {
      var temp = Quote.fromJson(node);
      // print(temp.author);
      quotesList.add(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        // leading: Icon(Icons.arrow_forward_ios),
      ),
      body: PageView.builder(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        itemCount: quotesList.length,
        itemBuilder: (context, index) {
          return quoteWidget(
            quote: quotesList[index].quoteText,
            author: quotesList[index].author,
            // likedIndex: index,
          );
        },
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DrawerHeader(
                    child: Text(
                  'Q',
                  style:
                      TextStyle(fontSize: 140.0, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 30.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Liked Quotes',
                    style: menuStyle,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Authors',
                    style: menuStyle,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Categories',
                    style: menuStyle,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.developer_mode,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Developers',
                    style: menuStyle,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
