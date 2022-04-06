import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> httpRequestPost(String urlStr, Map jsonText) async {
  var url = Uri.parse(urlStr);
  var body = json.encode(jsonText);
  var response = await http.post(url, body: body);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return json.decode(response.body);
}

Future<List<dynamic>> httpRequestGet(String urlStr, Map? jsonText) async {
  var url = Uri.parse(urlStr);
  if (jsonText != null) {
    url = url.replace(queryParameters: jsonText as Map<String, String>);
  }
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  return json.decode(response.body) as List<dynamic>;
}
