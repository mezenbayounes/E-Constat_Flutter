import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dpc_flutter/constant/utils.dart';
/*
Future userLogin(String email, String password) async {
  Uri url = Uri.parse(Utils.base_url);
  final response = await http.post(url.replace(path: '${url.path}/user/login'),
      headers: {"Accept": "Application/json"},
      body: {email: email, password: password});

  var decodedData = jsonDecode(response.body);
  return decodedData;
}
*/