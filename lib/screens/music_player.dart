import 'package:bhootify/models/file_model.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  final File file;
  const MusicPlayerScreen({Key? key, required this.file}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => MusicPlayerScreenState();
}

class MusicPlayerScreenState extends State<MusicPlayerScreen> {
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
                      child: const SizedBox(
                        height: 32.00,
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('images/back_button.png')),
                      ),
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
                    image: Image.asset(
                      'images/' + widget.file.thumbnailURL,
                      height: 200,
                    ),
                  ),
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
                    SizedBox(
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
              )
            ],
          ),
        ));
  }
}
