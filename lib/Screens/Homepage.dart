import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motivatory/Screens/authorPage.dart';
import 'package:motivatory/Screens/categoryPage.dart';
import 'package:motivatory/Screens/likedQuotes.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:motivatory/data/quotesModel.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:motivatory/data/theme.dart';

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
//    loadDatabase();
  }


//  loadDatabase() async {
//    print("Line1");
//
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    print("Line2");
//    String path = join(documentsDirectory.path, "working_data.db");
//    print("Line3 path");
//    print(path);
//    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
//      print("Inside");
//      ByteData data = await rootBundle.load(join("database", "en_quotes.db"));
//       print("Line4 data");
//       print(data);
//      List<int> bytes =
//          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//       print("This is Bytes");
//       print(bytes);
//      await new File(path).writeAsBytes(bytes);
//    }
//    else
//      {
//        print("Inside in");
////        Directory appDocDir = await getApplicationDocumentsDirectory();
////        String dbp= join(appDocDir.path, 'en_quotes.db');
////        print("at");
////        print(path);
////        print(dbp);
//      }
////    Directory appDocDir = await getApplicationDocumentsDirectory();
////    String databasePath = join(appDocDir.path, 'asset_database.db');
////    db = await openDatabase(databasePath);
//    db = await openDatabase(path);
//    print("This is db");
//    print(db);
//    return getAllQuotes();
//  }
loadDatabase()async{
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "main.db");

//  var exists= await databaseExists(path);
//  if(!exists){
  await deleteDatabase(path);
    print("Creating new copy from asset");

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("database", "en_quotes.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
//  }
//  else {
//    print("Opening existing database");
//    print(path);
//  }
  db = await openDatabase(path);
  return getAllQuotes();

  }



  getAllQuotes() async {
    quotesList = [];
    print("Check");
    var sql = '''SELECT * FROM ${Quotes.quoteTable}''';
    print("Check1");
    var data = await db.rawQuery(sql);

    print("This is data");
    print(sql);
    print(data.length);
    for (final node in data) {
      var temp = Quote.fromJson(node);
//       print(temp.author);
      quotesList.add(temp);
    }
    print("This is quote list");
    print(quotesList[1].author);
    return quotesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,

//      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
//        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Motivatory',
//          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,

//        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: FutureBuilder(
          future: loadDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  'Something went wrong!! \nPlease restart the app!!',
                  style: TextStyle(
//                      color: Colors.white,
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
            return PageView.builder(
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Random rand = Random();
                var temp = rand.nextInt(snapshot.data.length);
                return quoteWidget(
                  quote: snapshot.data[temp],
                );
              },
            );
          }),
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
                  'M',
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LikedQuotesPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
//                    color: Colors.white,
                  ),
                  title: Text(
                    'Authors',
                    style: menuStyle,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthorList()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.list,
//                    color: Colors.white,
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
                Consumer<ThemeNotifier>(
                  builder: (context, notifire, child) {
                    return notifire.darkTheme
                        ? ListTile(
                            leading: Icon(
                              Icons.wb_sunny,
//                    color: Colors.white,
                            ),
                            title: Text(
                              'Light Mode',
                              style: menuStyle,
                            ),
                            onTap: () {
                              notifire.toogleTheme();
                            },
                          )
                        : ListTile(
                            leading: Icon(
                              Icons.brightness_2,
//                    color: Colors.white,
                            ),
                            title: Text(
                              'Dark Mode',
                              style: menuStyle,
                            ),
                            onTap: () {
                              notifire.toogleTheme();
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
