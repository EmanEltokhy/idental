import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class NotificationHelper {
  static void registerNotification() async {
    // 1. Instantiate Firebase Messaging

    final FlutterLocalNotificationsPlugin notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    await FirebaseMessaging.instance.getNotificationSettings();
    final intializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {


            }));

    notificationsPlugin.initialize(intializationSettings);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      _getToken(FirebaseMessaging.instance);

      // For handling the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body!,
          htmlFormatBigText: true,
          contentTitle: message.notification!.title,
          htmlFormatContentTitle: true,
        );
        notificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
                android: AndroidNotificationDetails('idental', 'idental',
                    styleInformation: bigTextStyleInformation,
                    importance: Importance.high,
                    priority: Priority.high,
                    ticker: 'ticker',
                playSound: true)));

        // Parse the message received
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // go to appointment screen whether to approve or not
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
  static String? deviceToken;
  // final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static void _getToken(FirebaseMessaging  messaging) async {
    deviceToken = await messaging.getToken();
    print(deviceToken); // print the device token string
  }

//   static sendNotification(String token) async {
// print("calleddd");
// // FirebaseMessaging.instance.
//     await FirebaseMessaging.instance.sendMessage(
//       data: <String,String>{
//         'title': "test",
//         "body": "new Appointment"
//       },
//       to: token
//
//
//     );
//   }
  static late FlutterLocalNotificationsPlugin flutterlocalnotificationsplugin = new FlutterLocalNotificationsPlugin();
   static initInfo(){
    var androidInitialize = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializtionSettings = InitializationSettings(android: androidInitialize);
    flutterlocalnotificationsplugin.initialize(initializtionSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      print(".......................onMessage.............");
      print("onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation big = BigTextStyleInformation(
          message.notification!.body.toString(),htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),htmlFormatContentTitle: true
      );
      AndroidNotificationDetails android = AndroidNotificationDetails(
        'dbfood','dbfood',importance: Importance.high,
        styleInformation:big,priority: Priority.high,playSound: false,
      );
      NotificationDetails platform = NotificationDetails(android: android);
      await flutterlocalnotificationsplugin.show(0, message.notification?.title,message.notification?.body, platform,payload: message.data['body']);

    });
  }

  static void sendPushMessage(String token, String body, String title) async {
    try{
      await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String,String>{
            'Content-Type': 'application/json',
            'Authorization': 'AAAA6Zvpk_I:APA91bHExSlk_HkatYDfXO_BY4heJQhBMrt8NHBtgLZrDzsesUELp79VggzxiEtfsrxabqb-A_bZ9-sR6qum6PkIE'
                'vekQVa6BITVqDQs7HfrWHbBfUuE-9xTCRPLJAnC0FiPkcvf4WKg'
          },
          body: jsonEncode(
              <String,dynamic>{
                'priority':'high',
                'data':<String,dynamic>{
                  'click_action':'FLUTTER_NOTIFICATION_CLICK',
                  'status': 'done',
                  'body': body,
                  'title':title,
                },
                "notification": <String,dynamic>{
                  "title":title,
                  "body":body,
                  "android_channel_id":"idental"
                },
                "to":token,
              }
          )
      );
    }catch(e){
      if(kDebugMode){
        print("error push notification");
      }
    }
  }



}
