import 'package:dson_adapter/dson_adapter.dart';
//classe que define uma moeda com atributos nome e cotação
class Moeda {
  final String nome;
  final double cotacao;
  Moeda({
    required this.nome,
    required this.cotacao,
  });

  static Moeda fromJson(String nome, double cotacao) {
    return Moeda(
      nome: nome,
      cotacao: cotacao,
    );
  }
}

