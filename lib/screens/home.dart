import 'package:bhootify/providers/music_player_provider.dart';
import 'package:bhootify/screens/music_player.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/file_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void switchToMusicPlayer(context, index) {
    Provider.of<MusicPlayerProvider>(context, listen: false).setEntry(index);
    Provider.of<MusicPlayerProvider>(context, listen: false).initState();
    Provider.of<MusicPlayerProvider>(context, listen: false).start(index);

    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const MusicPlayerScreen()));
  }

  int increment = 10;
  loadMore() {
    setState(() {
      increment += 1;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<List<File>> files = context.watch<MusicPlayerProvider>().getFiles();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<List<File>>(
                future: files,
                builder: (context, AsyncSnapshot<List<File>> snapshot) {
                  if (snapshot.hasData) {
                    int itemCountTotal = snapshot.data!.length;

                    return LazyLoadScrollView(
                      onEndOfPage: () =>
                          loadMore(), // The callback when reaching the end of the list
                      scrollOffset: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: itemCountTotal < increment
                            ? itemCountTotal
                            : increment,
                        itemBuilder: (BuildContext context, int index) {
                          File currentEntry = snapshot.data![index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  focusColor:
                                      const Color.fromARGB(92, 250, 128, 22),
                                  borderRadius: BorderRadius.circular(8.0),
                                  highlightColor:
                                      const Color.fromARGB(92, 250, 128, 22),
                                  splashColor:
                                      const Color.fromARGB(178, 229, 107, 1),
                                  onTap: () =>
                                      switchToMusicPlayer(context, index),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 5.00, right: 5.00),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5.00),
                                          height: 70.00, //70
                                          width: 110.00,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 33, 33, 33),
                                            borderRadius:
                                                BorderRadius.circular(8.00),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 19, 19, 19)
                                                    .withOpacity(0.15),
                                                spreadRadius: 3,
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: OptimizedCacheImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    currentEntry.thumbnailURL,
                                              )),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.00),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 10.00),
                                                width: 250.00,
                                                child: Text(
                                                  currentEntry.title,
                                                  style: const TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 12.00,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                      fontWeight:
                                                          FontWeight.w300),
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
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color(0xFFFA7F16),
                    ));
                  }
                })
          ],
        ),
      ),
    );
  }
}
