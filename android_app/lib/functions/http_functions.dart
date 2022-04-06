import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> httpRequestPost(String urlStr) async {
  var url = Uri.parse(urlStr);
  var response = await http.post(url, body: {'name': 'Nader', 'color': 'blue'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

Future<void> httpRequestGet() async {
  var url = Uri.parse('http://localhost:3000/posts');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  final extractedMyInfo = json.decode(response.body) as List<dynamic>;
  print(extractedMyInfo[1]['title']);
}
