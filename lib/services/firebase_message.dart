import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../firebase_options.dart';

class FMessaging {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? mtoken;
  List<dynamic>? products;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  DefaultFirebaseOptions firebaseOptions = DefaultFirebaseOptions();

  void getChanges() async {
    DocumentReference reference = FirebaseFirestore.instance
        .collection(auth.currentUser!.uid)
        .doc("user_data");
    reference.snapshots().listen((querySnapshot) {
      products = querySnapshot.get("products");

      for (var index = 0; index <= products!.length; index++) {
        var now = DateTime.now();
        var product = products![index];
        if (product["expiry_date"] != null) {
          var expirationDate = DateTime.parse(product["expiry_date"]);
          final bool isExpired = expirationDate.isBefore(now);
          if (!isExpired && expirationDate.difference(now).inDays < 2) {
            sendPushMessage(
                mtoken.toString(),
                "Your ${product["name"]} has ${expirationDate.difference(now).inDays} days left until its expiration date!\nTry to consume it in the next few days",
                "Expiry Date");
          }
        }
      }
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=${firebaseOptions.firebase_message_token}'
          },
          body: jsonEncode(<String, dynamic>{
            'prioriity': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "FridgeIT"
            },
            "to": token,
          }));
    } catch (e) {
      print("Can't push notification");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token;
      print("My token is $token");
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection("${auth.currentUser?.uid}")
        .doc("user_token")
        .set({"token": token});
  }

  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@drawable/notification_icon');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: (String? payload) async {
      try {
        if (payload != null && payload.isNotEmpty) {
        } else {}
      } catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("....................onMessage....................");
      print(
          "onMessage  title: ${message.notification?.title}; body: ${message.notification?.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails('FridgeIT', 'FridgeIT',
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);
      NotificationDetails platformChannelSpecipics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecipics,
          payload: message.data['title']);
    });
  }
}
