import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    await DefaultAssetBundle.of(context).loadString("json/songs.json").then((s) {
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
             SizedBox(
              height: 20,
            ),
            Container(
              child: Container(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: songs == null ? 0 : songs.length,
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
            // Bcoz everything inside it will be scrollable and so   we used NestedScrollView
      // Expanded is used as it should cover all the remaining space
            Expanded(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      pinned: true,
                        backgroundColor: Colors.white,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          child: TabBar(
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.all(0),
                            controller: _tabController,
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 7,
                                  offset: Offset(0, 0),
                                )
                              ],
                            ),
                            tabs: [
                              Container(
                                width: 120,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Tab 1",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Tab 2",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Tab 3",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 7,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
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
                      itemCount: 20,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Item $index"),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Item $index"),
                      ),
                    ),
                    ListView.builder(
                      itemCount: 20,
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
