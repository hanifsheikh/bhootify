import 'package:bhootify/providers/music_player_provider.dart';
// import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<MusicPlayerScreen> createState() => MusicPlayerScreenState();
}

class MusicPlayerScreenState extends State<MusicPlayerScreen> {
  dynamic file = {};
  bool isPlaying = false;
  bool isLoading = true;
  dynamic player;

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
  Widget build(BuildContext context) {
    setState(() {
      player = Provider.of<MusicPlayerProvider>(context, listen: true).player;
      file =
          Provider.of<MusicPlayerProvider>(context, listen: true).selectedFile;
      isPlaying =
          Provider.of<MusicPlayerProvider>(context, listen: true).isPlaying;
      isLoading =
          Provider.of<MusicPlayerProvider>(context, listen: true).isLoading;
      duration =
          Provider.of<MusicPlayerProvider>(context, listen: true).duration;
      position =
          Provider.of<MusicPlayerProvider>(context, listen: true).position;
    });

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 26, 26, 26),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                  height: 200.0,
                  child: ClipRect(
                      child: OptimizedCacheImage(
                          imageUrl: file.thumbnailURL,
                          imageBuilder: (context, imageProvider) => Container(
                                height: 200.00,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )))),
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          color: Color(0xFFFFFFFF)),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      file.author,
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
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFFFA7F16),
                  inactiveTrackColor: const Color.fromARGB(255, 55, 55, 55),
                  thumbColor: const Color(0xFFFFFFFF),
                  trackShape: const RectangularSliderTrackShape(),
                  trackHeight: 3.0,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  overlayColor: const Color(0xFFFA7F16).withAlpha(32),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                ),
                child: SizedBox(
                  width: 400,
                  child: Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble() + 1.0,
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      Provider.of<MusicPlayerProvider>(context, listen: false)
                          .setSeekPosition(value);

                      // Optional: Play audio if was paused
                      // await player.resume();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatTime(position),
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins'),
                    ),
                    Row(children: [
                      Text(
                        formatTime(duration - position),
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(
                        width: 5.00,
                      ),
                      const Text(
                        '/',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(
                        width: 5.00,
                      ),
                      Text(
                        formatTime(duration),
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                      ),
                    ])
                  ],
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox.fromSize(
                        size: const Size(60, 60),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor:
                                  const Color(0xFFFA7F16), // splash color
                              onTap: () async {
                                await player.seek(Duration(
                                    seconds: position.inSeconds.toInt() - 10));
                              }, // button pressed
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.fast_rewind,
                                      color: Color(0xFFFFFFFF),
                                      size: 14,
                                    ),
                                  ), // icon
                                  Text(
                                    "10 sec",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400),
                                  ), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 24,
                          child: IconButton(
                            icon: const Icon(Icons.fast_rewind),
                            iconSize: 24,
                            color: const Color(0xFFFFFFFF),
                            onPressed: () => {},
                          )),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: isPlaying
                            ? const Color(0xFFFA7F16)
                            : const Color(0xFFFFFFFF),
                        child: IconButton(
                          icon: isLoading
                              ? const CircularProgressIndicator(
                                  color: Color(0xFFFA7F16),
                                )
                              : Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow),
                          iconSize: 24,
                          color: isPlaying
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFFA7F16),
                          onPressed: () async {
                            if (isPlaying) {
                              await player.pause();
                            } else {
                              await player.play(UrlSource(file.fileURL));
                            }
                          },
                        ),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 24,
                          child: IconButton(
                            icon: const Icon(Icons.fast_forward),
                            iconSize: 24,
                            color: const Color(0xFFFFFFFF),
                            onPressed: () async {},
                          )),
                      SizedBox.fromSize(
                        size: const Size(60, 60),
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor:
                                  const Color(0xFFFA7F16), // splash color
                              onTap: () async {
                                await player.seek(Duration(
                                    seconds: position.inSeconds.toInt() + 10));
                              }, // button pressed
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  // icon
                                  Text(
                                    "10 sec",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Icon(
                                      Icons.fast_forward,
                                      color: Color(0xFFFFFFFF),
                                      size: 14,
                                    ),
                                  ), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
