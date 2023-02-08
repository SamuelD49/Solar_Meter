import 'package:chartt/chart.dart';
import 'package:chartt/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int pageIndex = 0;

  final pages = [
    Chart('ch1'),
    Chart('ch2'),
    Chart('ch3'),
    Chart('ch4'),
    Chart('ch5'),
    Chart('ch6'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: const Icon(
                  Icons.auto_graph,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 4;
                  });
                },
                icon: const Icon(
                  Icons.work_outline_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 5;
                  });
                },
                icon: const Icon(
                  Icons.widgets_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
