import 'package:android_app/widgets/Push%20Notifications/notification_badge.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification {
// String messageTitle = "Empty";
// String notificationAlert = "alert";

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;

  PushNotification({this.title, this.body, this.dataTitle, this.dataBody});

  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
}

class NotificationGenerator extends StatefulWidget {
  NotificationGenerator();

  @override
  State<NotificationGenerator> createState() => _NotificationGeneratorState();
}

class _NotificationGeneratorState extends State<NotificationGenerator> {
  late final _messaging;
  PushNotification? _notificationInfo;
  late int _totalNotificationCount;

  @override
  void initState() {
    //sending notifications when app is running normally
    registerNotification();
    _totalNotificationCount = 0;
//to send notifications when app is terminated
    checkForInitialMessage();
//to send the notification when the app is running in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification!.title,
        body: message.notification!.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _totalNotificationCount++;
        _notificationInfo = notification;
      });
    });
    super.initState();
  }

  //registering the notification
  void registerNotification() async {
    await Firebase.initializeApp();
    //after we initialize the firebase app we need to create an instance for the messaging
    _messaging = FirebaseMessaging.instance;

    //creating a notification setting so that we control the sound and vibrations that the notifications make
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted the permission");

      //main message is sent from here
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        setState(() {
          _totalNotificationCount++;
          _notificationInfo = notification;
        });

        if (notification != null) {
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            elevation: 16,
            background: Colors.white,
            leading: NotificationBadge(totalCount: _totalNotificationCount),
            subtitle: Text(_notificationInfo!.body!),
            duration: Duration(seconds: 5),
          );
        }
      });
    } else {
      print("Permission eclined by user");
    }
  }

//checking the initial message that we receive so the notifications are sent when app is terminated
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification!.title,
        body: initialMessage.notification!.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      setState(() {
        _totalNotificationCount++;
        _notificationInfo = notification;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //empty container
    return Container(
        // child: Column(
        //   children: [
        //     const SizedBox(height: 220),
        //     RichText(
        //       text: const TextSpan(
        //         style: TextStyle(
        //           fontSize: 14.0,
        //           color: Colors.black,
        //         ),
        //         children: <TextSpan>[
        //           TextSpan(
        //             text: 'Push notification page',
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 30.0,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ],
        //       ),
        //     ),
        //     NotificationBadge(totalCount: _totalNotificationCount),
        //     //if notification info is not null
        //     _notificationInfo != null
        //         ? Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Text(
        //                 "TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}",
        //                 // ignore: prefer_const_constructors
        //                 style:
        //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //               ),
        //               SizedBox(height: 9),
        //               Text(
        //                 "BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}",
        //                 style:
        //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //               ),
        //             ],
        //           )
        //         : Container(),
        //   ],
        // ),
        // margin: const EdgeInsets.all(30),
        );
  }
}
