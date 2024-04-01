
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
      List<Moeda> moedas = []; //lista de moedas instanciada

      final response = await httpClient.get(path: "latest");
      //tratamento do json para ser passar pra lista de moedas
      Map<String, dynamic> data = jsonDecode(response);
      Map<String, dynamic> rates = data['rates'];

      rates.forEach((nome, cotacao) {
        moedas.add(Moeda.fromJson(nome, cotacao));
        //adiciona cada moeda na lista a partir do nome e cotacao correspondendo aos atributos de Moeda
      });
      //retornamos a lista de moedas do qual pegamos na requisição
      return moedas;
    } catch (error) {
      print(error);
      return [];
    }
  }
}