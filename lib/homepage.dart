import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook_app/tabs.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();

  List songs = []; // List to hold songs data

  ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  void readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/songs.json")
        .then((s) {
      setState(() {
        songs = json.decode(s); // Decode JSON string into List
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(
                    AssetImage("assets/Images/menu.png"),
                    size: 22,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10),
                      Icon(Icons.notifications),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "Popular Songs",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Container(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: songs.isEmpty ? 0 : songs.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(songs[i]["img"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(45),
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 15, left: 25),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            tabs: [
                              Tab(
                                text: "New",
                                // Removed the icon as requested
                              ),
                              Tab(
                                text: "Trending",
                              ),
                              Tab(
                                text: "Popular",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: songs.isEmpty ? 0 : songs.length,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(songs[index]["img"]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 24,
                                            color: const Color.fromARGB(255, 255, 230, 88),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            songs[index]["rating"],
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        songs[index]["title"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        songs[index]["text"],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Avenir',
                                          color: Colors.black,

                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue.shade900
                                        ),
                                        child: Text(
                                       "Love",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Avenir',
                                          color: Colors.white,
                                          
                                        ),
                                      ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Item $index"),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Item $index"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Homepage(),
  ));
}
