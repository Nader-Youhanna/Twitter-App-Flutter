import 'package:android_app/widgets/Tweets/tweet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AllNotificationsList extends StatefulWidget {
  const AllNotificationsList();

  @override
  State<AllNotificationsList> createState() => _AllNotificationsListState();
}

class _AllNotificationsListState extends State<AllNotificationsList>
    with AutomaticKeepAliveClientMixin<AllNotificationsList> {
  @override
  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();
  List<String> notificationItems = [];
  bool loading = false;
  bool allLoaded = false;

//mocking what would happen with actual apis
  mockFetch() async {
    if (allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(milliseconds: 1000)); //mock delay for await
    List<String> newData = notificationItems.length >= 60
        ? []
        : List.generate(
            20,
            (index) =>
                "List Item ${index + notificationItems.length}"); //generating mock list elements->TODO:get elements from apis
    if (newData.isNotEmpty) {
      notificationItems.addAll(newData);
    }

    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mockFetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        //this means that we reached the bottom of the page and we are no longer loading

        mockFetch();
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
      child: notificationItems.isNotEmpty
          ? Stack(children: [
              ListView.separated(
                padding: const EdgeInsets.all(5),
                controller: _scrollController,
                itemCount: notificationItems.length,
                itemBuilder: (BuildContext context, int index) {
                  //return notificationItems[index];
                  return Container(
                    //this container should contain actual notifications not list elements
                    height: 100,
                    color: Colors.white,
                    child: Center(child: Text(notificationItems[index])),
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
