import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const httpCallTimeout = Duration(seconds: 60);

class HttpClient {
  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*'
  };

  String serverUrl;

  HttpClient({required this.serverUrl});

  Future get(
      {required String path, Map<String, String>? additionalHeaders}) async {
    final url = Uri.parse("$serverUrl/$path");
    final request = http.get(url,
        headers: {...headers, ...?additionalHeaders}).timeout(httpCallTimeout);
    final response = await request;
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw HttpClientError(
          path, response.statusCode, utf8.decode(response.bodyBytes));
    }
    final bodyString = utf8.decode(response.bodyBytes);
    return bodyString;
  }


}

class HttpClientError extends Error {
  String path;
  int statusCode;
  String? mensagem;

  HttpClientError(this.path, this.statusCode, [this.mensagem]) {
    debugPrint("Erro $statusCode no $path");
  }

  @override
  String toString() {
    return mensagem ?? "Erro $statusCode";
  }
}
