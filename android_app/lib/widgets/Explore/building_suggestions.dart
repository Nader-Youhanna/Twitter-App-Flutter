import './search_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../functions/http_functions.dart';
import '../../constants.dart';

//this is a class to get the suggestion list for the search bar
class BuildingSuggestions {
  List<SearchItem> searchResults = [];
  var data = [];
  Future<List<SearchItem>> getSearchItems({String? query}) async {
    print("Adding search elements");

    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/search");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        searchResults = data.map((e) => SearchItem.jsonSearchItem(e)).toList();
        if (query != null) {
          //we filter the list that we got according to the query
          searchResults = searchResults
              .where((element) => element.username
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return searchResults;
  }
}