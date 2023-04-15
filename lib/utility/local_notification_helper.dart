import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alarmplayer/alarmplayer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io' as p;
import 'package:http/http.dart' as http;

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}

@pragma('vm:entry-point')
class LocalNotificationHelper {
  //Instances
  static final flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  String selectedNotificationPayload = '';
  static final BehaviorSubject<ReceivedNotification>
  didReceiveLocalNotificationSubject =
  BehaviorSubject<ReceivedNotification>();

  static final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  //Methods

  static Future<void> intialize() async {
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    _requestPermissions();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('mipmap/launcher_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
            int? id,
            String? title,
            String? body,
            String? payload,
            ) async {
          didReceiveLocalNotificationSubject.add(
            ReceivedNotification(
              id: id!,
              title: title!,
              body: body!,
              payload: payload!,
            ),
          );
        });
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  static void _requestPermissions() async {
    var status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  static void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification.body);
    });
  }

  @pragma('vm:entry-point')
  static Future<void> showNotification(RemoteMessage message) async {
    print(message.data);
    await Firebase.initializeApp();
    //if (message.data["image"].toString().isNotEmpty) {
      //print(message.data["image"]);
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your alarm channel id',
        'your alarm channel name',
        channelDescription: 'your alarm channel description',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
    //   await flutterLocalNotificationsPlugin.show(
    //     DateTime.now().millisecond,
    //     message.data["title"],
    //     message.data["body"],
    //     platformChannelSpecifics,
    //   );
    // Alarmplayer alarmplayer = Alarmplayer();
    // alarmplayer.Alarm(
    //   url: "assets/song/sound_one.mp3",
    //   volume: 0.3
    // );
    // await Future.delayed(Duration(seconds: 30));
    // alarmplayer.StopAlarm();
    // } else {
    //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //   AndroidNotificationDetails(
    //     'the Call',
    //     'the call',
    //     channelDescription: 'the call notification',
    //     importance: Importance.high,
    //     priority: Priority.high,
    //     ticker: 'ticker',
    //     sound: RawResourceAndroidNotificationSound('sound_one'),
    //     //audioAttributesUsage: AudioAttributesUsage.alarm,
    //   );
    //   const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails();
    //   const NotificationDetails platformChannelSpecifics = NotificationDetails(
    //       android: androidPlatformChannelSpecifics,
    //       iOS: iosNotificationDetails);
    //   await flutterLocalNotificationsPlugin.show(
    //     DateTime.now().millisecond,
    //     message.data["title"],
    //     message.data["body"],
    //     platformChannelSpecifics,
    //     payload: json.encode(message.data),
    //   );
    // }
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final p.Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      //await Navigator.pushNamed(context, '/secondPage');
    });
  }

  static void onSelectNotification(payload) async {
    var data = json.decode(payload);
    print(data);
  }

  static cancelNotififcationWithID(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static cancelAllNotififcation() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
