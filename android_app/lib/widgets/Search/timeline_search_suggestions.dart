import 'package:android_app/functions/tweet_functions.dart';

import '../Tweets/tweet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../functions/http_functions.dart';
import '../../constants.dart';

///this is a class built to fetch the suggestion list for the search bar from server
class BuildingTimelineSuggestions {
  Future<List<Tweet>> getSearchItems({String? query}) async {
    String token = '';
    List<Tweet> searchResults = await getTweets(token);

    if (query != null) {
      //we filter the list that we got according to the query

      searchResults = searchResults
          .where((element) => element
              .getTweetText()
              .toLowerCase()
              .contains((query.toLowerCase())))
          .toList();
    }

    return searchResults;
  }
}
