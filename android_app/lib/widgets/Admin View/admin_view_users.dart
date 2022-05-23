import 'package:flutter/material.dart';
import '../../constants.dart';
import 'admin_view_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminViewUsers extends StatefulWidget {
  @override
  State<AdminViewUsers> createState() => AdminViewUsersState();
  String name = "";
  String userName = "";
  String userImage = '';
  bool isAdmin = false;
  String email = '';
  String token;
  AdminViewUsers(
      {required this.name,
      required this.userName,
      required this.userImage,
      required this.isAdmin,
      required this.email,
      required this.token});
}

class AdminViewUsersState extends State<AdminViewUsers> {
  List<Map<String, String>> jsonAdminUser = [
    {"name": "Habiba", "username": "@habiba25"},
    {"name": "Farida", "username": "@fofaaa34"},
    {"name": "Ahmed", "username": "@Moodi77"},
    {"name": "Mohamed", "username": "@MohamedKarim26"},
    {"name": "Nounou", "username": "@noraa1990"},
    {"name": "Nader", "username": "@Nidoo"},
    {"name": "Nada", "username": "@NadaT2000"},
    {"name": "Habiba", "username": "@HabibaAssem2000"},
    {"name": "Ahmed", "username": "@Moodi77"},
    {"name": "Mohamed", "username": "@MohamedKarim26"},
    {"name": "Nounou", "username": "@noraa1990"}
  ];

  Future<List<AdminViewUser>> _getStaticAdminUsersList() async {
    List<AdminViewUser> userList = <AdminViewUser>[];
    await Future.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < jsonAdminUser.length; i++) {
        userList
            .add(AdminViewUser.jsonAdminUser(jsonAdminUser[i], widget.token));
        //print(userList[i].name);
      }
    });
    return userList;
  }

  Future<List<AdminViewUser>> _getAdminUsersList() async {
    List<AdminViewUser> userList = <AdminViewUser>[];
    var data = [];
    print("fetching Users in Admin view");
    var url = Uri.parse("http://$MY_IP_ADDRESS:3000/search?q=f&f=user");
    Map<String, dynamic> headers = {
      "Authorization": "Bearer " + widget.token,
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

    // searchResults =
    //     mapData['users'].map((e) => SearchItem.jsonSearchItem(e)).toList();
    for (int i = 0; i < mapData['users'].length; i++) {
      userList
          .add(AdminViewUser.jsonAdminUser(mapData['users'][i], widget.token));
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return FutureBuilder<List<AdminViewUser>>(
        future: _getAdminUsersList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.data == null) {
                return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      // SizedBox(height: 100),
                      Center(child: CircularProgressIndicator()),
                      SizedBox(height: 50),
                      Center(child: Text('Server error..please wait')),
                    ]);
              } else {
                List<AdminViewUser> data = snapshot.data!;

                return data.isNotEmpty
                    ? RefreshIndicator(
                        child: ListView.builder(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.all(0),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (data[index].isDeleted) {
                                print('deleteeeedddd');
                                data.removeAt(index);
                                setState(() {});
                              }
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
                            }),
                        onRefresh: () async {
                          _getAdminUsersList();
                          setState(() {});
                        },
                        triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      )
                    : Container(
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
              }
          }
        });
  }
}
