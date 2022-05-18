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
          'Authorization': 'Bearer ' + token
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
    return FutureBuilder<List<AdminViewUser>>(
        future: _getAdminUsersList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              List<AdminViewUser> data = snapshot.data!;

              return RefreshIndicator(
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
                    }),
                onRefresh: () async {
                  _getAdminUsersList();
                  setState(() {});
                },
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
              );
          }
        });
  }
}
