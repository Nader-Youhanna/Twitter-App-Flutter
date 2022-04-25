import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'notification_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../constants.dart';
import '../../functions/http_functions.dart';

class AllNotificationsList extends StatefulWidget {
  AllNotificationsList();

  // List<NotificationItem> notificationList = <NotificationItem>[];
  @override
  State<AllNotificationsList> createState() => _AllNotificationsListState();
}

class _AllNotificationsListState extends State<AllNotificationsList> {
  //with AutomaticKeepAliveClientMixin<AllNotificationsList> {
  // @override
  // bool get wantKeepAlive => true;
  // final ScrollController _scrollController = ScrollController();

  bool loading = false;
  bool allLoaded = false;

//Function to get the list of notifications and their types from backend
  Future<List<NotificationItem>> _getNotifications() async {
    List<NotificationItem> notificationList = <NotificationItem>[];
    var data = [];
    print("Adding notifications");
    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/notifications");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        notificationList =
            data.map((e) => NotificationItem.jsonNotification(e)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }

    return notificationList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance!.addPostFrameCallback((_) =>
    //     _getNotifications()); //function is called everytime we open the page
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationItem>>(
        future: _getNotifications(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
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
                                height: 100,
                                //color: Colors.white,
                                child: data[index],
                              );
                            },
                          ),
                          onRefresh: () async {
                            _getNotifications();
                            setState(() {});
                          },
                          triggerMode: RefreshIndicatorTriggerMode.anywhere,
                        )
                      ])
                    : Container(
                        child: Column(
                          children: [
                            const SizedBox(height: 220),
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
                      ),
              );
          }
        });
  }
}
