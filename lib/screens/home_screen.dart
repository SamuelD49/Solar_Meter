//@dart=2.9
import 'dart:async';
import 'package:chartt/ass.dart';
import 'package:chartt/chart.dart';
import 'package:chartt/model/channal.dart';
import 'package:chartt/widget/nav.dart';

import '/screens/login_screen.dart';
import '/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:splashscreen/splashscreen.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, right: 5),
              child: PopupMenuButton(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    size: 35,
                  ),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Icon(
                                      Icons.account_circle_sharp,
                                      color: Colors.green,
                                      size: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'Api-user',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextButton(
                                  child: Text("Logout"),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.green,
                                    side: BorderSide(
                                        color: Colors.green, width: 1),
                                    shadowColor: Colors.green,
                                    elevation: 20,
                                  ),
                                  onPressed: () async {
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .logout();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          value: 1,
                        ),
                      ]),
            )
          ],
          leading: Image.asset('assets/danlogo.png'),
          title: Text("Dan Energy ")),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Lottie.asset('assets/greenbulb.json',
                  repeat: false, alignment: Alignment.bottomCenter),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                    /*   Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chart()),
                      ); */
                    },
                    child: Card(
                      shadowColor: Colors.lime,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                          leading: Image.asset('assets/solarcell.png'),
                          title: Text('  Solar Energy',
                              style: TextStyle(fontSize: 23)),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Nav()),
                      );
                    },
                    child: Card(
                      shadowColor: Colors.lime,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                            leading: Image.asset('assets/dsl.png'),
                            title: Text(
                              '  Diesel Generator',
                              style: TextStyle(fontSize: 23),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/energy');
                    },
                    child: Card(
                      shadowColor: Colors.lime,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                          leading:
                              Icon(Icons.power, size: 70, color: Colors.blue),
                          title: Text('Energy Consumpiton',
                              style: TextStyle(fontSize: 23)),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
