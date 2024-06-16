import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/audiofile.dart'; // This should now import 'MyAudiofile'
import 'package:audioplayers/audioplayers.dart' as audioplayers; // Import 'audioplayers' with a prefix

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  late audioplayers.AudioPlayer advancedPlayer; // Use the 'audioplayers' prefix here

  @override
  void initState() {
    super.initState();
    advancedPlayer = audioplayers.AudioPlayer(); // Use the 'audioplayers' prefix here
  }

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F8),
      body: Stack(
        children: [
          // Your existing widget tree
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
                  SizedBox(height: screenheight * 0.1),
                  Text(
                    "The Water Cure",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Welcome to SK",
                    style: TextStyle(fontSize: 20),
                  ),
                  Audiofile( // Use MyAudiofile instead of Audiofile
                    advancedPlayer: advancedPlayer,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
