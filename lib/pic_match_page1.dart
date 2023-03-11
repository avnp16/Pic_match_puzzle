import 'package:flutter/material.dart';

class PicMatch1 extends StatefulWidget {
  const PicMatch1({Key? key}) : super(key: key);

  @override
  State<PicMatch1> createState() => _PicMatch1State();
}

class _PicMatch1State extends State<PicMatch1> {
  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    double appbarh=kToolbarHeight;
    double bottombarh=MediaQuery.of(context).padding.top;

    double bodyheight= h-appbarh-bottombarh;



    return Scaffold(
      appBar: AppBar(
        title: Text("Picture Match"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: w*0.025),
            height: bodyheight*0.70,
            width: w*0.95,
            child: GridView.builder(
              itemCount: 12,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blueGrey,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
