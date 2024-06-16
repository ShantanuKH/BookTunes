import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class Audiofile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final  audioPath;

  const Audiofile({Key? key, required this.advancedPlayer , required this.audioPath}) : super(key: key);

  @override
  _AudiofileState createState() => _AudiofileState();
}

class _AudiofileState extends State<Audiofile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  bool isPlaying = false;
  bool isRepeat = false;
  bool loop = false;
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

    widget.advancedPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    this.widget.advancedPlayer.setSourceUrl(this.widget.audioPath);
    this.widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);

        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
        ;
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      onPressed: () {
        if (!isPlaying) {
          widget.advancedPlayer.play(this.widget.audioPath);
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

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/Images/fordward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/Images/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/Images/repeat.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat == true;
            color:
            Colors.blue;
          });
        } else if (isRepeat == true) {
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          color:
          Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget btnloop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/Images/loop.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnStart(),
          btnFast(),
          btnSlow(),
          btnRepeat(),
          btnloop(),
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          SizedBox(height: 16),
          loadAsset(),
          SizedBox(height: 16),
          slider(),
        ],
      ),
    );
  }
}
