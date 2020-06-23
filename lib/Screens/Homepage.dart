import 'package:flutter/material.dart';
import 'package:motivatory/Screens/categoryPage.dart';
import 'package:motivatory/data/quotesData.dart';
import 'package:motivatory/resources/styles.dart';
import 'package:motivatory/widgets/quoteDisplayWidget.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          return quoteWidget(
            quote: quotes[index]["quote"],
            author: quotes[index]["author"],
            likedIndex: index,
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
                DrawerHeader(child: Text('Q',style: TextStyle(fontSize: 140.0,fontWeight: FontWeight.bold),)),
                SizedBox(height: 30.0,),
                ListTile(
                  leading: Icon(Icons.favorite,color: Colors.red,),
                  title: Text('Liked Quotes',style: menuStyle,),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit,color: Colors.white,),
                  title: Text('Authors',style: menuStyle,),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list,color: Colors.white,),
                  title: Text('Categories',style: menuStyle,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.developer_mode,color: Colors.white,),
                  title: Text('Developers',style: menuStyle,),
                  onTap: () {
                    
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
