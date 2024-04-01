import '../domain/moeda.dart';

abstract class MoedasServiceClient {
  Future<List<Moeda>> getAllMoedas();
}

