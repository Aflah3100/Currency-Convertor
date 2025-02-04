// To parse this JSON data, do
//
//     final countryLists = countryListsFromJson(jsonString);

import 'dart:convert';

Map<String, String> countryListsFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) => MapEntry<String, String>(k, v));

String countryListsToJson(Map<String, String> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
