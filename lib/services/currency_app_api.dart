import 'dart:convert';

import 'package:currency_convert/models/country_list.dart';
import 'package:currency_convert/models/currency_rate.dart';
import 'package:currency_convert/utils/keys.dart';
import 'package:http/http.dart' as http;

abstract class CurrencyAppApi {
  //fetch-current-rates
  Future<Map<String, dynamic>> fetchCurrentRates();

  //fetch-countries
  Future<List<String>> fetchCountries();
}

class CurrencyAppServer implements CurrencyAppApi {
  //Singleton-Object
  CurrencyAppServer._private();
  static CurrencyAppServer instance = CurrencyAppServer._private();
  factory CurrencyAppServer() => instance;

  @override
  Future<List<String>> fetchCountries() async {
    final uri = Uri.parse(
        'https://openexchangerates.org/api/currencies.json?app_id=$app_id');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final countryListsMap = countryListsFromJson(response.body);

      final countryLists = countryListsMap.keys.toList();

      return countryLists;
    } else {
      throw Exception('Error Fectching Countries');
    }
  }

  @override
  Future<Map<String, double>> fetchCurrentRates() async {
    final uri = Uri.parse(
        'https://openexchangerates.org/api/latest.json?app_id=$app_id');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final jsonObject = CurrencyRates.fromJson(jsonResponse);
      return jsonObject.rates;
    } else {
      throw Exception('Failed to Load Rates');
    }
  }
}
