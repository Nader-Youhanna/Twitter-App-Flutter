import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';

Future<void> httpRequestPost(
    String urlStr, Map? reqBody, Map<String, String> reqHeaders) async {
  var url = Uri.parse(urlStr);
  var body = json.encode(reqBody);
  var response = await http.post(url, body: body, headers: reqHeaders);
  return json.decode(response.body);
}

Future<List<dynamic>> httpRequestGet(String urlStr, Map? jsonText) async {
  var url = Uri.parse(urlStr);
  var request = Request('GET', url);

  if (jsonText != null) {
    request.body = json.encode(jsonText);
  }

  // var response = await http.get(url,headers: {
  //   "Content-Type": "application/json",
  // });
  var response = await request.send();

  String strResponse = await response.stream.bytesToString();

  print('Response status: ${response.statusCode}');
  print('Response body of GET: $strResponse');
  return json.decode(strResponse);
}
