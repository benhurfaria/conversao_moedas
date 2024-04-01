import 'dart:async';

import 'package:flutter/material.dart';


import '../domain/moeda.dart';
import 'moedas_service_client.dart';

const pollingInterval = 15;

class MoedasStore extends ChangeNotifier {
  final MoedasServiceClient moedasService;

  List<Moeda> moedasList = [];

  MoedasStore(this.moedasService) : super() {
    syncMoedas();
    //aqui temos basicamente um timer para atualizar as moedas na cotação/moedas disponiveis dentro de syncMoedas()
    Timer.periodic(const Duration(seconds: pollingInterval), (_) {
      syncMoedas();
    });
  }

  Future<void> syncMoedas() async {
    //nesta função atualizamos os atributos das moedas com o timer definido acima.
    try {
      moedasList.clear();
      List moedas = await moedasService.getAllMoedas();
      if(moedas.isNotEmpty){
        moedasList.clear();
        for (var moeda in moedas) {
          moedasList.add(moeda);
        }
      }
      notifyListeners();
    } catch (error) {
      debugPrint('Erro ao sincronizar moedas: $error');
    }
  }
}