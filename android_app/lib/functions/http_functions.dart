import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<void> httpRequestPost(String urlStr, Map reqBody, Map reqHeaders) async {
  var url = Uri.parse(urlStr);
  if (reqBody == null) {
    reqBody = <String, dynamic>{};
  }
  if (reqHeaders == null) {
    reqHeaders = <String, String>{};
  }
  var body = json.encode(reqBody);
  var response = await http.post(
    url,
    body: body,
    headers: reqHeaders as Map<String, String>,
  );
  print(response.body);
  return json.decode(response.body);
}

Future<Map<String, dynamic>> httpRequestGet(
    String urlStr, Map? headersMap) async {
  var url = Uri.parse(urlStr);

  var request = http.Request('GET', url);

  if (headersMap != null) {
    request.headers['Content-Type'] = headersMap['Content-Type'];
    request.headers['authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNjg4ZWM5OWEzNjc3NWIzNDZlNmEyZSIsImlhdCI6MTY1MTA1MDA0NSwiZXhwIjoxNjU5NjkwMDQ1fQ.0SN29hZpZ7kyHWQbm8MiFBLOtGLmbcei43kwLFfSJHQ';
  }

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  //Print the last 10 characters of the response body
  //print(response.body.substring(response.body.length - 15));
  print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body.substring(1000)}');
  var temp = json.decode(response.body) as Map<String, dynamic>;

  return temp;
}
