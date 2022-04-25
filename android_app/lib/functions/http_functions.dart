import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<void> httpRequestPost(String urlStr, Map reqBody, Map reqHeaders) async {
  var url = Uri.parse(urlStr);
  var body = json.encode(reqBody);
  var response = await http.post(
    url,
    body: body,
    headers: reqHeaders as Map<String, String>,
  );
  print(response.body);
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
  print('Response body: $strResponse');
  return json.decode(strResponse);
}
