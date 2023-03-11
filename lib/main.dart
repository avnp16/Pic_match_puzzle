import 'package:flutter/material.dart';
import 'package:picture_match/pic_match_page1.dart';

void main(){

  runApp(myapp());

}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: PicMatch1()

    );
  }
}
