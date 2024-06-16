import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
// To init audiofile
// This late will tell compiler that the constrictor is initialiazation will be done later
  late AudioPlayer advancedPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    // We took this as based on different mobile screen/different devices we will get the same position
    // We are etaking device height/width using mediaquery
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFfdee7fa),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenheight / 3,
              child: Container(color: Colors.blue.shade500)),
          // AppBar Sathi
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
                // backgroundColor: Colors.blue, ---> We can chnage the backgrounf color like this too but we will make it transperent

                backgroundColor: Colors.transparent,
                elevation:
                    0.0 // By default there is elevation in the appbar and so, though we give background transperent we will see light grey coloe and to fix that we use elevation
                ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: screenheight * 0.2,
              height: screenheight * 0.38,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenheight * 0.1,
                    ),
                    Text(
                      "The Water Cure",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Welcome to SK",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )),

          Positioned(
              // For the small box in the middle
              top: screenheight * 0.12,
              // 150 is the width of the box that we want
              left: (screenwidth - 150) / 2,
              right: (screenwidth - 150) / 2,
              height: screenheight * 0.16,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          image: DecorationImage(
                              image: AssetImage("assets/Images/pic-1.png"),
                              fit: BoxFit.cover)),
                    ),
                  )))
        ],
      ),
    );
  }
}
