//@dart=2.9
import 'dart:async';

import '/services/constants.dart';
import '/services/provider.dart';
import '/screens/home_screen.dart';
import '/screens/login_screen.dart';
import '/services/provider.dart';
import '/services/requests.dart';
import '/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DataProvider(), child: Startapp());
  }
}

class Startapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userToken = Provider.of<DataProvider>(context).user[TOKEN_KEY] ?? "";
    return Provider.of<DataProvider>(context).userChecked
        ? (userToken.length > 0
            ? MaterialApp(
                home: HomeScreen(),
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                debugShowCheckedModeBanner: false,
              )
            : MaterialApp(
                home: LoginForm(),
                theme: ThemeData(
                  primarySwatch: Colors.green,
                ),
                debugShowCheckedModeBanner: false,
              ))
        : MaterialApp(
            home: Text("loading.."),
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            debugShowCheckedModeBanner: false,
          );
    // MaterialApp(
    //     initialRoute: '/',
    //     routes: {'/': (context) => HomeScreen()},
    //     theme: ThemeData(
    //       primarySwatch: Colors.green,
    //     ),
    //     debugShowCheckedModeBanner: false,
    //   )

    //  MaterialApp(
    //     initialRoute: '/',
    //     routes: {'/': (context) => LoginForm()},
    //     theme: ThemeData(
    //       primarySwatch: Colors.green,
    //     ),
    //     debugShowCheckedModeBanner: false,
    //   );
  }
}
