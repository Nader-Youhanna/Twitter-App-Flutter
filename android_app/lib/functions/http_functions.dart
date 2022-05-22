import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../constants.dart';

jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}

Future<void> httpMultipartFilePostRequest(
    Map<String, dynamic> data, List<http.MultipartFile> files) async {
  try {
    //var request = http.MultipartRequest("POST", Uri.parse(URL.postTweet));
    var request =
        http.MultipartRequest("POST", Uri.parse('http://10.0.2.2:3000/post'));
    request.headers['Authorization'] = constToken;
    request.headers['Content-Type'] = 'multipart/form-data';

    request = jsonToFormData(request, data);

    for (var file in files) {
      request.files.add(file);
    }

    print("Request = " + request.toString());
    print(request.files.toString());
    print(request.fields.toString());
    var response = await request.send();
    print(response.statusCode);
    var responseData = await response.stream.toBytes();
    print(String.fromCharCodes(responseData));
  } catch (e) {
    print(e);
  }
}

/// This function returns the response of the http POST request. It takes URL, body and headers as parameters.
Future<Map<String, dynamic>> httpRequestPost(
    String urlStr, Map reqBody, Map reqHeaders) async {
  var url = Uri.parse(urlStr);

  var body = json.encode(reqBody);
  var response = await http.post(
    url,
    body: body,
    headers: reqHeaders as Map<String, String>,
  );
  print("Status code " + response.statusCode.toString());
  return json.decode(response.body) as Map<String, dynamic>;
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
    request.headers['Authorization'] = headersMap['Authorization'];
  }

  var streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  print('Response status: ${response.statusCode}');
  var temp = json.decode(response.body) as Map<String, dynamic>;

  return temp;
}
