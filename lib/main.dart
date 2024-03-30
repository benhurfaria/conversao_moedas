import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          Stack(
            alignment: AlignmentDirectional.center,
            children:[
              Container(color: Colors.red,),
              Container(color: Colors.blue, height: 100,),
            ],
          ),
    );
  }
}
