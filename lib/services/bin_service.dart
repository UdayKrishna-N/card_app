import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:tuple/tuple.dart';

class BinService {
  static String baseUrl = "https://lookup.binlist.net/";

  Future<dynamic> getBinData(String bin) async {
    try {
      var url = Uri.parse(baseUrl + bin);
      var response = await http.get(url, headers: {
        "Accept-Version": "3",
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        throw Exception('Failed to check BIN.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
