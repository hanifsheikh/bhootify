import 'package:bhootify/screens/music_player.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/file_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<File>> files = getFiles();

  static Future<List<File>> getFiles() async {
    const url = "https://bhootify.mastersigner.com";
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    return body.map<File>(File.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF383736),
      body: SafeArea(
          child: Stack(
        children: [
          FutureBuilder<List<File>>(
              future: files,
              builder: (context, AsyncSnapshot<List<File>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      File currentEntry = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          focusColor: const Color.fromARGB(92, 250, 128, 22),
                          borderRadius: BorderRadius.circular(8.0),
                          highlightColor:
                              const Color.fromARGB(92, 250, 128, 22),
                          splashColor: const Color.fromARGB(178, 229, 107, 1),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      MusicPlayerScreen(file: currentEntry))),
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 5.00, right: 5.00),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5.00),
                                  height: 70.00,
                                  width: 110.00,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.00),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 19, 19, 19)
                                            .withOpacity(0.15),
                                        spreadRadius: 3,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      currentEntry.thumbnailURL,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(left: 10.00),
                                      width: 250.00,
                                      child: Text(
                                        currentEntry.title,
                                        style: const TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.00, top: 5.00),
                                      width: 250.00,
                                      child: Text(
                                        currentEntry.author,
                                        style: const TextStyle(
                                            color: Color(0xFFAAAAAA),
                                            fontSize: 10.00,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.00, top: 5.00),
                                      width: 250.00,
                                      child: Text(
                                        currentEntry.duration,
                                        style: const TextStyle(
                                            color: Color(0xFFAAAAAA),
                                            fontSize: 10.00,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      )),
    );
  }
}
