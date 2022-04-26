import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

///Same as the notifications but with mentions
class MentionsList extends StatefulWidget {
  const MentionsList();

  @override
  State<MentionsList> createState() => _MentionsListState();
}

class _MentionsListState extends State<MentionsList>
    with AutomaticKeepAliveClientMixin<MentionsList> {
  @override
  bool get wantKeepAlive => true;

  final ScrollController _scrollController = ScrollController();
  List<String> mentionItems = [];
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

    await Future.delayed(Duration(milliseconds: 1000));
    // List<String> newData = mentionItems.length >= 60
    //     ? []
    //     : List.generate(
    //         20, (index) => "List Item ${index + mentionItems.length}");//generating mock list elements->TODO:get elements from apis
    List<String> newData =
        []; //to test displaying the text->but it works just like the other page
    if (newData.isNotEmpty) {
      mentionItems.addAll(newData);
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
      child: mentionItems.isNotEmpty
          ? Stack(children: [
              ListView.separated(
                padding: const EdgeInsets.all(5),
                controller: _scrollController,
                itemCount: mentionItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    //this container should contain actual notifications not list elements
                    height: 100,
                    color: Colors.white,
                    child: Center(child: Text(mentionItems[index])),
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
                              'When someone on Sirius mentions you in a Tweet or reply, you\'ll find it here.',
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
