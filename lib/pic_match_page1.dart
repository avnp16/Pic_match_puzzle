import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicMatch1 extends StatefulWidget {
  PicMatch1({Key? key}) : super(key: key) {
    log("main contrcuctor");
  }

  @override
  State<PicMatch1> createState() {
    log("from create state");

    return _PicMatch1State();
  }
}

class _PicMatch1State extends State<PicMatch1> {
  bool val = true;
  List<bool> isVisable = List.filled(12, true);
  int click = 1;
  int pos1 = 0;
  int pos2 = 0;

  List<String> img = [
    "aguacate.png",
    "ajo.png",
    'ardilla.png',
    'barco.png',
    'bellota.png',
    'bombon.png',
    "aguacate.png",
    "ajo.png",
    'ardilla.png',
    'barco.png',
    'bellota.png',
    'bombon.png',
  ];

  int score = 0;
  int highScore = 0;

  getsp() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove("score");
    highScore = sp.getInt("high") ?? 0;
  }

  @override
  void initState() {
    log("initstate called");
    super.initState();

    Future.delayed(const Duration(seconds: 5)).then((value) {
      isVisable = List.filled(12, false);

      setState(() {});
    });

    img.shuffle();
    getsp();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("did change dep");
  }

  @override
  void didUpdateWidget(covariant PicMatch1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("did update widget");
  }

  @override
  void dispose() {
    super.dispose();
    log("dispose called");
  }

  @override
  Widget build(BuildContext context) {
    log("build method called");

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double appbarh = kToolbarHeight;
    double bottombarh = MediaQuery.of(context).padding.top;

    double bodyheight = h - appbarh - bottombarh;
    int i = 1;

    var myst = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    Stream<int> time() async* {
      for (i = 1; i <= 30; i++) {
        await Future.delayed(const Duration(seconds: 1));
        yield i;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Picture Match"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Score :$score", style: myst),
                Text(
                  "Highest Score :$highScore",
                  style: myst,
                ),
              ],
            ),
          ),
          // StreamBuilder(
          //   stream: time(),
          //   builder: (context, snapshot) {
          //     print(snapshot.data);
          //
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     } else {
          //       int t = snapshot.data as int;
          //
          //       return Slider(
          //         min: 1.0,
          //         max: 30.0,
          //         value: t.toDouble(),
          //         onChanged: (value) {},
          //       );
          //     }
          //   },
          // ),
          Container(
            margin: EdgeInsets.only(left: w * 0.025),
            height: bodyheight * 0.70,
            width: w * 0.95,
            child: GridView.builder(
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Visibility(
                  visible: isVisable[index],
                  replacement: InkWell(
                    onTap: () async {
                      if (click == 1) {
                        isVisable[index] = true;
                        pos1 = index;
                        click = 3;

                        Future.delayed(const Duration(milliseconds: 10))
                            .then((value) {
                          setState(() {
                            click = 2;
                          });
                        });
                      }

                      if (click == 2) {
                        isVisable[index] = true;
                        pos2 = index;
                        click = 3;

                        if (img[pos1] == img[pos2]) {
                          log("match");

                          final sp = await SharedPreferences.getInstance();
                          int tempscore = sp.getInt("score") ?? 0;
                          tempscore = tempscore + 10;

                          sp.setInt('score', tempscore);
                          log(tempscore.toString());

                          int temphighscore = sp.getInt("high") ?? 0;

                          if (temphighscore < tempscore) {
                            temphighscore = tempscore;
                            sp.setInt('high', temphighscore);
                          }

                          score = tempscore;
                          highScore = temphighscore;
                        } else {
                          final sp = await SharedPreferences.getInstance();
                          int tempscore = sp.getInt("score") ?? 0;
                          tempscore = tempscore - 5;
                          score = tempscore;

                          sp.setInt('score', tempscore);
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) {
                            setState(() {
                              isVisable[pos1] = false;
                              isVisable[pos2] = false;
                            });
                          });

                          log("not match");
                        }

                        Future.delayed(const Duration(seconds: 1))
                            .then((value) {
                          setState(() {
                            click = 1;
                          });
                        });
                      }

                      setState(() {});
                    },
                    child: Container(
                      color: Colors.teal,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        image: DecorationImage(
                            image: AssetImage("assets/images/${img[index]}"))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
