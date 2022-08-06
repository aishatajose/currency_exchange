import 'dart:async';
import 'dart:convert';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AbstractApiService {
  String apiKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"; //Insert your Abstract api key
  String baseUrl = "https://exchange-rates.abstractapi.com/v1/live/";


  Future<dynamic> getExchangeRate(Currency baseCurrency, Currency quoteCurrency) async {
    try 
    {
      http.Client _httpClient = http.Client();
      final response = await _httpClient
        .get(
          Uri.parse(baseUrl + "?api_key=$apiKey&base=${baseCurrency.code}&target=${quoteCurrency.code}"), 
          headers: {
            "Content-Type": "application/json",
          }
        )
        .timeout(const Duration(minutes: 1));

        Map<String, dynamic> responseJson = json.decode(response.body);
        return responseJson['exchange_rates'][quoteCurrency.code].toDouble();
    }
    catch(e){
      debugPrint(e.toString());
      return -1.0;
    }
  }
}