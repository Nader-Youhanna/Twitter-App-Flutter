import './search_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../functions/http_functions.dart';
import '../../constants.dart';

///this is a class built to fetch the suggestion list for the search bar from server
class BuildingSuggestions {
  List<SearchItem> searchResults = [];

  Future<List<SearchItem>> getSearchItems({String? query}) async {
    print("Adding search elements");

    var url = Uri.parse("http://$MY_IP_ADDRESS:3000/search?q=f&f=user");
    Map<String, dynamic> headers = {
      "Authorization": token,
      "Content-Type": "application/json"
    };

    var request = http.Request('GET', url);
    if (headers != null) {
      request.headers['Content-Type'] = headers['Content-Type'];
      request.headers['Authorization'] = headers['Authorization'];
    }
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response Body: ${response.body}');
    var mapData = json.decode(response.body);
    print("body is decoded");

    searchResults = mapData.map((e) => SearchItem.jsonSearchItem(e)).toList();
    print("kkkkkkkkkkk");
    if (query != null) {
      //we filter the list that we got according to the query

      searchResults = searchResults
          .where((element) => element.username != ""
              ? element.username.toLowerCase().contains((query.toLowerCase()))
              : element.trends.toLowerCase().contains((query.toLowerCase())))
          .toList();
    }

    return searchResults;
    // }
  }
}
