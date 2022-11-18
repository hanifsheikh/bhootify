import 'package:flutter/material.dart';

import '../models/file_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _shadowOffset = 8;
  void toggleShadow() {
    setState(() {
      if (_shadowOffset == 8) {
        _shadowOffset = 20;
      } else {
        _shadowOffset = 8;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 5.00, right: 5.00),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.00),
                        height: 60.00,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.00),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 19, 19, 19)
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
                          child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'images/' + files[index].thumbnailURL)),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10.00),
                            width: 250.00,
                            child: Text(
                              files[index].title,
                              style: const TextStyle(
                                  fontSize: 12.00, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.00, top: 5.00),
                            width: 250.00,
                            child: Text(
                              files[index].author,
                              style: const TextStyle(
                                  fontSize: 10.00, fontWeight: FontWeight.w300),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(left: 10.00, top: 5.00),
                            width: 250.00,
                            child: Text(
                              files[index].duration,
                              style: const TextStyle(
                                  fontSize: 10.00, fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
