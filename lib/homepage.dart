import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
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
              SizedBox(height: 20), // Added SizedBox to give space
              Container(
                // margin: const EdgeInsets.only(l),
                child: Text(
                  "Popular Songs",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                height: 180,
                child: PageView.builder(
                  // The PageController(viewportFraction: 0.8) in Flutter is used to control a PageView widget with a specific configuration where each page takes up a fraction of the viewport width
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: 5,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/Images/pic-8.png'),
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
