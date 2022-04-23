import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'notification_item.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../functions/http_functions.dart';

class AllNotificationsList extends StatefulWidget {
  AllNotificationsList();

  List<NotificationItem> notificationList = <NotificationItem>[];
  @override
  State<AllNotificationsList> createState() => _AllNotificationsListState();
}

class _AllNotificationsListState extends State<AllNotificationsList>
    with AutomaticKeepAliveClientMixin<AllNotificationsList> {
  @override
  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();

  bool loading = false;
  bool allLoaded = false;

//Function to get the list of notifications and their types from backend
  void _getNotifications() async {
    print("Adding notifications");
    httpRequestGet("http://${MY_IP_ADDRESS}:3000/notifications", null)
        .then((value) {
      setState(() {
        widget.notificationList.clear();
        for (var i = 0; i < value.length; i++) {
          widget.notificationList
              .add(NotificationItem.jsonNotification(value[i]));
        }
      });
    });
  }

  addingLoading() async {
    if (allLoaded) {
      return;
    }
    _getNotifications();
    setState(() {
      loading = true;
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => addingLoading()); //function is called everytime we open the page
    ;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        //this means that we reached the bottom of the page and we are no longer loading

        addingLoading();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: widget.notificationList.isNotEmpty
          ? Stack(children: [
              ListView.separated(
                padding: const EdgeInsets.all(5),
                controller: _scrollController,
                itemCount: widget.notificationList.length,
                itemBuilder: (BuildContext context, int index) {
                  //return notificationItems[index];
                  return Container(
                    //this container should contain actual notifications not list elements
                    height: 100,
                    color: Colors.white,
                    //child: Center(child: Text(notificationItems[index])),
                    child: widget.notificationList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 1,
                ),
              ),
              if (loading) ...[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: 400,
                    height: 80,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
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
}
