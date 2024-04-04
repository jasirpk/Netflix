import 'package:flutter/material.dart';
import 'package:netflix/screens/home_screen.dart';
import 'package:netflix/screens/newand_hot.dart';
import 'package:netflix/screens/search_screen.dart';

class Bottom_Screen extends StatefulWidget {
  const Bottom_Screen({super.key});

  @override
  State<Bottom_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Bottom_Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(
                  Icons.photo_library_outlined,
                ),
                text: "New & Hot",
              )
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xff999999),
          ),
        ),
        body: TabBarView(
          children: [
            Home_screen(),
            Search_Screen(),
            NewAndHot_Screen(),
          ],
        ),
      ),
    );
  }
}
