import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_ebook_app/audiofile.dart'; // Import your Audiofile widget

class AudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const AudioPage({Key? key, this.booksData, required this.index})
      : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F8),
      body: Stack(
        children: [
          // Background color section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight / 3,
            child: Container(color: Colors.blue.shade500),
          ),
          // App bar section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  advancedPlayer.stop();
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Implement your search button functionality
                  },
                ),
              ],
              backgroundColor: Colors.transparent, // Make app bar transparent
              elevation: 0.0, // Remove app bar shadow
            ),
          ),
          // Main content section
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.2,
            height: screenHeight * 0.38,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Text(
                    this.widget.booksData[this.widget.index]["title"],
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this.widget.booksData[this.widget.index]["text"],
                    style: TextStyle(fontSize: 20),
                  ),
                  Audiofile(
                    advancedPlayer: advancedPlayer,
                    audioPath: this.widget.booksData[this.widget.index]
                        ["audio"],
                  ), // Use your Audiofile widget here
                ],
              ),
            ),
          ),
          // Small box in the middle section
          Positioned(
            top: screenHeight * 0.12,
            left: (screenWidth - 150) / 2,
            right: (screenWidth - 150) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 227, 227, 227),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    image: DecorationImage(
                      image: AssetImage(
                        this.widget.booksData[this.widget.index]["img"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
