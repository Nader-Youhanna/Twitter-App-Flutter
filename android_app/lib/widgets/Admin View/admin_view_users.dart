import 'package:flutter/material.dart';
import '../../constants.dart';
import 'admin_view_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminViewUsers extends StatefulWidget {
  @override
  State<AdminViewUsers> createState() => AdminViewUsersState();
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
      userList =
          jsonAdminUser.map((e) => AdminViewUser.jsonAdminUser(e)).toList();
      for (int i = 0; i < jsonAdminUser.length; i++) {
        userList.add(AdminViewUser.jsonAdminUser(jsonAdminUser[i]));
        //print(userList[i].name);
      }
    });
    return userList;
  }

  Future<List<AdminViewUser>> _getAdminUsersList() async {
    List<AdminViewUser> userList = <AdminViewUser>[];
    var data = [];
    print("fetching Users in Admin view");
    var url = Uri.parse("http://${MY_IP_ADDRESS}:3000/users");
    try {
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + constToken
        },
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        userList = data.map((e) => AdminViewUser.jsonAdminUser(e)).toList();
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }

    return userList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return FutureBuilder<List<AdminViewUser>>(
        future: _getStaticAdminUsersList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              List<AdminViewUser> data = snapshot.data!;

              return data.isNotEmpty
                  ? RefreshIndicator(
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
        });
  }
}
