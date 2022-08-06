import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AbstractApi {
  String apiKey = "xxxxxxxxxxxxxxxxxxxxxxxx"; //Insert your Abstract api key
  String baseUrl = "https://exchange-rates.abstractapi.com/v1/live/";

  Future<Map<String, String>> headers() async {
    return {
      "Content-Type": "application/json",
    };
  }

  Future<dynamic> get(String fromCurrency, String toCurrency) async {
    var responseJson;
    try 
    {
      http.Client _httpClient = http.Client();
      final response = await _httpClient
        .get(Uri.parse(baseUrl + "?api_key=$apiKey&base=$fromCurrency&target=$toCurrency"), headers: await headers())
        .timeout(const Duration(minutes: 1));

    responseJson = json.decode(response.body);
    }
    catch(e){
      debugPrint(e.toString());
    }

    return responseJson;
  }

}