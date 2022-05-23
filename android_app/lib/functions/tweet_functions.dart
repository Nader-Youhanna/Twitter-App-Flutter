import 'dart:io';

import 'package:android_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

import './http_functions.dart';
import '../widgets/Tweets/tweet.dart';

import 'dart:convert';
//import 'dart:ffi';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

///This function sends the tweet to the [ipAddress] and port [port] of the backend and return the response.
Future<Map<String, dynamic>> addTweet(Map<String, dynamic> data) async {
  Map<String, String> headers = {
    "Authorization": 'Bearer ' + constToken,
    "Content-Type": "application/json"
  };
  return await httpRequestPost(
    URL.postTweet,
    data,
    headers,
  );
}

/// This function get the tweets from the [ipAddress] and port [port] of the backend and return the response.
Future<List<Tweet>> getTweets() async {
  print("Adding tweets");
  Map<String, dynamic> headers = {
    "Authorization": "Bearer " + constToken,
    "Content-Type": "application/json"
  };
  Map<String, dynamic> mapTweet = await httpRequestGet(URL.getTweets, headers);

  //print("=========" + mapTweet['data'][0].toString());
  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet['data'].length; i++) {
    // print("i = " + i.toString());
    // print(mapTweet['data'][i].toString());
    tweets.add(Tweet.jsonTweet(mapTweet['data'][i], false, true));
  }

  return tweets;
}

/// This function opens the modal sheet to add a new tweet and send it to the [ipAddress] and port [port].
void startAddTweet(BuildContext ctx) async {
  String tweetText = "";
  var tweetTextController = TextEditingController();
  List<File>? _image = [];
  final picker = ImagePicker();
  List<http.MultipartFile> files = <http.MultipartFile>[];

  //get width and height of the screen
  double width = MediaQuery.of(ctx).size.width;
  double height = MediaQuery.of(ctx).size.height;
  showModalBottomSheet(
    context: ctx,
    builder: (bCtx) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text('Cancel'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      tweetText = tweetTextController.text;
                      //check for tagged users
                      List<String?> taggedUsers = [];
                      RegExp exp = RegExp(r'@[a-zA-Z0-9]+');
                      Iterable<RegExpMatch> matches = exp.allMatches(tweetText);
                      for (var match in matches) {
                        taggedUsers.add(match.group(0));
                      }

                      var data = {
                        "body": tweetText,
                        "taggedUsers": taggedUsers,
                      };

                      if (_image != null) {
                        //there is an image
                        print("sending with image");
                        try {
                          upload(_image!, data, URL.postTweet);
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        //no image
                        print("sending without image");
                        addTweet(data);
                      }

                      //print(taggedUsers);
                      Navigator.pop(ctx);
                      return;
                    },
                    child: const Text('Tweet'),
                  ),
                ],
              ),
              //add tweet
              Container(
                padding: const EdgeInsets.all(10),
                //take input text from user
                child: TextField(
                  decoration: const InputDecoration.collapsed(
                    hintStyle: TextStyle(
                      fontFamily: 'RalewayMedium',
                      fontSize: 14.5,
                    ),
                    hintText: 'What\'s happening?',
                  ),
                  controller: tweetTextController,
                ),
              ),
              if (_image != null)
                Row(
                  children: [
                    for (int i = 0; i < _image!.length; i++)
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Image.file(_image![i],
                            width: width / 5, height: height / 5),
                      ),
                  ],
                ),

              //Add image button
              TextButton.icon(
                  onPressed: () async {
                    _image = await getImage(picker);

                    mystate() {}
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Add Image'))
            ],
          );
        },
      );
    },
    isScrollControlled: true,
    enableDrag: false,
    useRootNavigator: true,
  );
}

Future<Map<String, dynamic>> addComment(
    String tweetId, Map<String, dynamic> data) async {
  Map<String, dynamic> headers = {
    "Authorization": "Bearer " + constToken,
    "Content-Type": "application/json"
  };

  String url = URL.postReply.replaceAll(":tweetId", tweetId);
  var response = await httpRequestPost(url, data, headers);
  print(response);

  return response;
}

void upload(List<File> imageFile, Map<String, dynamic> data, String url) async {
  var uri = Uri.parse(url);
  var request = http.MultipartRequest("POST", uri);

  for (int i = 0; i < imageFile.length; i++) {
    var stream =
        http.ByteStream(DelegatingStream.typed(imageFile[i].openRead()));
    var length = await imageFile[i].length();
    var multipartFile = http.MultipartFile('image', stream, length,
        filename: basename(imageFile[i].path));
    request.files.add(multipartFile);
  }

  request.headers['Authorization'] = 'Bearer ' + constToken;
  //convert data to Map<String,String>
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}

Future<List<File>?> getImage(ImagePicker picker) async {
  if (Platform.isAndroid) {
    final pickedFile = await picker.pickMultiImage();

    int maxImages = 4;
    if (pickedFile != null && pickedFile.length < 4) {
      maxImages = pickedFile.length;
    }
    List<File> _image = [];
    for (int i = 0; i < maxImages; i++) {
      _image.add(File(pickedFile![i].path));
    }
    if (pickedFile!.isNotEmpty) {
      return _image;
    } else {
      print('No image selected.');
      return null;
    }
  }
}

//get replies
Future<List<Tweet>> getReplies(String tweetId, String userName) async {
  Map<String, dynamic> headers = {
    "Authorization": 'Bearer ' + constToken,
    "Content-Type": "application/json"
  };
  Map<String, dynamic> mapTweet = await httpRequestGet(
      URL.getReplies.replaceAll(':tweetId', tweetId), headers);

  //print("=========" + mapTweet['data'][0].toString());
  List<Tweet> tweets = <Tweet>[];
  for (int i = 0; i < mapTweet['Replies'].length; i++) {
    Tweet tweet = Tweet.jsonReply2(mapTweet['Replies'][i], false, false);
    //tweet.setReplyTo(userName);
    tweets.add(tweet);
  }

  return tweets;
}
