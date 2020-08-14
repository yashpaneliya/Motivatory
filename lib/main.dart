//import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cipher/flutter_cipher.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:motivatory/resources/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Homepage.dart';
import 'data/localLikeSQL.dart';
import 'package:provider/provider.dart';
import 'package:motivatory/data/theme.dart';

//import 'package:encrypt/encrypt.dart';
//import 'package:flutter/src/foundation/key.dart';
bool darkTheme = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Databasecreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("First Call");
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, notifier, child) {
//          darkTheme=!darkTheme;
          print(notifier.darkTheme);
          print("OK Call");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Motivatory',
            theme:notifier.darkTheme? ThemeData(
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.white),
                iconTheme: IconThemeData(color: Colors.white),

                color: Colors.black ,
                textTheme: TextTheme(
                    headline6: TextStyle(
                        color: Colors.white,
                        fontFamily: 'R',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)
                        ),
                elevation: 0.0,
              ),
//              backgroundColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              fontFamily: 'R',
              brightness:   Brightness.dark,
            ): ThemeData(
              appBarTheme: AppBarTheme(
                actionsIconTheme: IconThemeData(color: Colors.black),
                iconTheme: IconThemeData(color: Colors.black),
                color:  Colors.white,
                textTheme: TextTheme(
                    headline6:TextStyle(
                        color: Colors.black,
                        fontFamily: 'R',
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                elevation: 0.0,
              ),
//              backgroundColor:  Colors.white,
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'R',
              brightness: Brightness.light,
            ),
            home: Homepage(),
          );
        },
      ),
    );
  }

  void onThemeChanged(var val, var themeChanger) async {
    val == 0
        ? themeChanger.setTheme(darktheme)
        : themeChanger.setTheme(lighttheme);
//    var pref= await SharedPreferences.getInstance();
//    pref.setInt('darkmode',val);
  }

  static getThemevalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int theme_val = prefs.getInt('darkmode') ?? 0;
    return theme_val;
  }
}
