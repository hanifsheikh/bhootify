import 'package:bhootify/models/file_model.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerScreen extends StatefulWidget {
  final File file;
  const MusicPlayerScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => MusicPlayerScreenState();
}

class MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void initState() {
    super.initState();

    // Listen to states: playing, paused, stopped.
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // Listen to audio duration
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    // Listen to audio position
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF383736),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: SizedBox(
                          height: 32.00,
                          child: Image.network(widget.file.thumbnailURL,
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                        child: Container(
                            child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5.00),
                          child: const Text(
                            'NOW',
                            style: TextStyle(
                                color: Color(0xFFFA7F16),
                                fontSize: 16.0,
                                letterSpacing: 2.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: const Text(
                            'PLAYING',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )))
                  ],
                ),
              ),
              Container(
                height: 280.0,
                child: ClipRect(
                  child: DropShadowImage(
                      offset: Offset(10, 10),
                      scale: 1,
                      blurRadius: 10,
                      borderRadius: 20,
                      image:
                          Image.network(widget.file.thumbnailURL, height: 200)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.file.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          letterSpacing: 1.2,
                          fontSize: 14.0,
                          color: Color(0xFFFFFFFF)),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      widget.file.author,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          letterSpacing: 1.2,
                          fontSize: 10.0,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ],
                ),
              ),
              Slider(
                  min: 0,
                  thumbColor: const Color(0xFFFFFFFF),
                  inactiveColor: const Color.fromARGB(255, 92, 92, 92),
                  activeColor: const Color(0xFFFA7F16),
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await player.seek(position);

                    // Optional: Play audio if was paused
                    // await player.resume();
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(duration),
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      formatTime(duration - position),
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: isPlaying
                    ? const Color(0xFFFA7F16)
                    : const Color(0xFFFFFFFF),
                child: IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 24,
                  color: isPlaying
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFFFA7F16),
                  onPressed: () async {
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      await player.play(UrlSource(widget.file.fileURL));
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
