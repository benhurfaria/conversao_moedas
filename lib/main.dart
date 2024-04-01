import 'package:moedas/application/moedas_store.dart';
import 'package:moedas/infra/moedas_service_client_http_impl.dart';

import 'application/moedas_service_client.dart';
import 'infra/http_client.dart';

import 'package:flutter/material.dart';

import 'presentation/drop_page.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  static const host = "https://api.frankfurter.app";

  @override
  Widget build(BuildContext context) {
    final HttpClient httpClient = HttpClient(serverUrl: host); //httpclient será responsavel pelas requisições
    final MoedasServiceClient moedasService = MoedasServiceClientHttpImpl(httpClient);
    final MoedasStore moedasStore = MoedasStore(moedasService);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Teste de estágio em mobile: Conversor de moedas'),
        ),
        body: DropPage(moedasStore),
      ),
    );
  }
}



