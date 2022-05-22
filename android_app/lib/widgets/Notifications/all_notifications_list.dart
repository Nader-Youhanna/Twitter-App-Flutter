import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'notification_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import '../../functions/http_functions.dart';

class AllNotificationsList extends StatefulWidget {
  //constructor should take user token from notifications page
  AllNotificationsList();

  // List<NotificationItem> notificationList = <NotificationItem>[];
  @override
  State<AllNotificationsList> createState() => AllNotificationsListState();
}

///class that creates the notification's list
class AllNotificationsListState extends State<AllNotificationsList> {
  //with AutomaticKeepAliveClientMixin<AllNotificationsList> {
  // @override
  // bool get wantKeepAlive => true;
  // final ScrollController _scrollController = ScrollController();

  ///Function to get the list of notifications and their types from backend
  Future<List<NotificationItem>> getNotifications() async {
    List<NotificationItem> notificationList = <NotificationItem>[];

    print("Adding notifications");
    // var url = Uri.parse(
    //     "http://$MY_IP_ADDRESS:3000/getnotifications"); //url used for mock server
    var url = Uri.parse(
        "http://$MY_IP_ADDRESS:3000/home/getNotifications"); //url used for backend
    Map<String, dynamic> headers = {
      "Authorization": 'Bearer ' + constToken,
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
    //print('Response Body: ${response.body}');

    var mapData = json.decode(response.body);

    for (int i = 0; i < mapData['notificationsArray'].length; i++) {
      if (NotificationItem.jsonNotification(mapData['notificationsArray'][i])
                  .notificationType !=
              'reply' &&
          NotificationItem.jsonNotification(mapData['notificationsArray'][i])
                  .notificationType !=
              'tag')
        notificationList.add(NotificationItem.jsonNotification(
            mapData['notificationsArray'][i]));
    }
    // for (int j = 0; j < notificationList.length; j++) {
    //   if (notificationList[j].notificationType == 'reply' ||
    //       notificationList[j].notificationType == 'tag') {
    //     notificationList.removeAt(j);
    //   }
    // }
    return notificationList;
  }

//should impliment function to send token to backend

  bool isAndroid = true;
  @override
  void initState() {
    isAndroid = (defaultTargetPlatform == TargetPlatform.android);
    super.initState();
//function to send token should be put here
    // WidgetsBinding.instance!.addPostFrameCallback((_) =>
    //_getNotifications()); //function is called everytime we open the page
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // print("height: $height \n");
    // print("width is $width");
    return FutureBuilder<List<NotificationItem>>(
        future: getNotifications(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.data == null) {
                // return Column(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       // SizedBox(height: 100),
                //       Center(child: CircularProgressIndicator()),
                //       SizedBox(height: 50),
                //       Center(
                //         child: Text('Server error..please wait'),
                //       )
                //     ]);
                return Container(
                  child: Column(
                    children: [
                      SizedBox(height: height * (220 / 825.5)),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Join the conversation\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  'From Retweets to likes and awhole lot more, this is where all the action happens about you Tweets and followers. You\'ll like it here.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 100, 99, 99),
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //padding: const EdgeInsets.all(30),
                  margin: const EdgeInsets.all(30),
                );
              } else {
                List<NotificationItem> data = snapshot.data!;
                return Container(
                    child: data.isNotEmpty
                        ? Stack(children: [
                            RefreshIndicator(
                              child: ListView.builder(
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(0),
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    //this container should contain actual notifications not list elements
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    height: height * (100 / 825.5),
                                    //color: Colors.white,
                                    child: data[index],
                                  );
                                },
                              ),
                              onRefresh: () async {
                                getNotifications();
                                setState(() {});
                              },
                              triggerMode: RefreshIndicatorTriggerMode.anywhere,
                            )
                          ])
                        : RefreshIndicator(
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: height * (220 / 825.5)),
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Join the conversation\n',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              'From Retweets to likes and awhole lot more, this is where all the action happens about you Tweets and followers. You\'ll like it here.',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 100, 99, 99),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(30),
                            ),
                            onRefresh: () async {
                              getNotifications();
                              setState(() {});
                            },
                            triggerMode: RefreshIndicatorTriggerMode.anywhere,
                          ));
              }
          }
        });
  }
}
