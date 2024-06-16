import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Audiofile extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  const Audiofile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  State<Audiofile> createState() => _AudiofileState();
}

class _AudiofileState extends State<Audiofile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  String path = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
  bool isPlaying = false;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    
    widget.advancedPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    widget.advancedPlayer.onAudioPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    widget.advancedPlayer.setUrl(path);
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: () {
        if (!isPlaying) {
          widget.advancedPlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        } else {
          widget.advancedPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
      icon: isPlaying
          ? Icon(_icons[1], size: 50, color: Colors.blue)
          : Icon(_icons[0], size: 50, color: Colors.blue),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnStart(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        changeToSeconds(value.toInt());
      },
    );
  }

  void changeToSeconds(int second) {
    Duration newDuration = Duration(seconds: second);
    widget.advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          loadAsset(),
          slider(),
        ],
      ),
    );
  }
}
