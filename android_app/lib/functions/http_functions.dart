import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

/// This function returns the response of the http POST request. It takes URL, body and headers as parameters.
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

///This function returns the response of the http Patch request. It takes URL, body and headers as parameters.
Future<void> httpRequestPatch(
    String urlStr, Map reqBody, Map reqHeaders) async {
  var url = Uri.parse(urlStr);
  if (reqBody == null) {
    reqBody = <String, dynamic>{};
  }
  if (reqHeaders == null) {
    reqHeaders = <String, String>{};
  }
  var body = json.encode(reqBody);
  var response = await http.patch(
    url,
    body: body,
    headers: reqHeaders as Map<String, String>,
  );
  print(response.body);
  return json.decode(response.body);
}

/// This function returns the response of the http POST request. It takes URL, body and headers as parameters.
Future<Map<String, dynamic>> httpRequestGet(
    String urlStr, Map? headersMap) async {
  var url = Uri.parse(urlStr);

  var request = http.Request('GET', url);

  if (headersMap != null) {
    request.headers['Content-Type'] = headersMap['Content-Type'];
    request.headers['authorization'] = headersMap['authorization'];
  }

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  print('Response status: ${response.statusCode}');
  var temp = json.decode(response.body) as Map<String, dynamic>;

  return temp;
}
