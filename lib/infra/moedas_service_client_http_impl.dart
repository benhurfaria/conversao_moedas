
import 'dart:convert';

import 'http_client.dart';
import '../application/moedas_service_client.dart';
import '../domain/moeda.dart';


class MoedasServiceClientHttpImpl extends MoedasServiceClient {
  final HttpClient httpClient;

  MoedasServiceClientHttpImpl(
      this.httpClient);


  @override
  Future<List<Moeda>> getAllMoedas() async {
    try {
      List<Moeda> moedas = [];

      final response = await httpClient.get(path: "latest");

      Map<String, dynamic> data = jsonDecode(response);
      Map<String, dynamic> rates = data['rates'];

      rates.forEach((nome, cotacao) {
        moedas.add(Moeda.fromJson(nome, cotacao));
      });

      return moedas;
    } catch (error) {
      print(error);
      return [];
    }
  }
}