import 'package:flutter/material.dart';

import 'drop_page.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Teste de estágio em mobile: Conversor de moedas'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {}),
        body: Row(
          children: [
            Container(width:300, height:100, child: DropPage(),),
            Container(width:300, height:100, child: DropPage(),),
          ],
        ),
      ),
    );
  }
}



