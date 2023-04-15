import 'dart:io';
import 'package:alarmplayer/alarmplayer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:wakiewakie/screen/home_screen.dart';
import 'config/environment.dart';
import 'notifiers/notifier.dart';
import 'resources/color_resourse.dart';
import 'package:http/http.dart' as http;
import 'resources/srting_resourse.dart';
import 'screen/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: Environment.fileName);
  await Firebase.initializeApp();
  await NotificationController.initializeLocalNotifications();
  //await LocalNotificationHelper.intialize();
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (!kIsWeb) {
      NotificationController.createNewNotification(message);
    }
  });
  FirebaseMessaging.onBackgroundMessage(
      NotificationController.createNewNotification);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});
  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Notifier()),
      ],
      child: MaterialApp(
        title: StringRes.appName,
        navigatorKey: MyApp.navigatorKey,
        theme: ThemeData(
          sliderTheme:
              SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
          primaryColor: ColorRes.whiteColor,
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: StringRes.fontPoppins),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: ColorRes.whiteColor,
          fontFamily: StringRes.fontPoppins,
          appBarTheme: AppBarTheme(
            backgroundColor: ColorRes.primaryColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorRes.primaryColor,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class NotificationController {
  static ReceivedAction? initialAction;

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://mipmap/launcher_icon', //'drawable/res_app_icon',//
      [
        NotificationChannel(
          channelGroupKey: 'category_tests',
          channelKey: 'alarm_channel',
          channelName: 'Alarms Channel',
          channelDescription: 'Channel with alarm ringtone',
          playSound: false,
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          enableVibration: true,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
        ),
      ],
      debug: true,
    );
    // Get initial notification action is optional
    initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("Click action" + receivedAction.toString());

    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
      print('Message sent via notification input: "${receivedAction.buttonKeyPressed}"');
      //await executeLongTaskInBackground();
    } else {
      print("Click action" + receivedAction.toString());
      // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      //     '/notification-page',
      //         (route) =>
      //     (route.settings.name != '/notification-page') || route.isFirst,
      //     arguments: receivedAction);
    }
    await Future.delayed(Duration(seconds: 2));
  }

  static Future<void> executeLongTaskInBackground() async {
    print("starting long task");
    await Future.delayed(const Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  static Future<bool> displayNotificationRationale() async {
    bool userAuthorized = false;
    BuildContext context = MyApp.navigatorKey.currentContext!;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Get Notified!',
                style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/animated-bell.gif',
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                    'Allow Awesome Notifications to send you beautiful notifications!'),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Deny',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  )),
              TextButton(
                onPressed: () async {
                  userAuthorized = true;
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Allow',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.deepPurple),
                ),
              ),
            ],
          );
        });
    return userAuthorized &&
        await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  @pragma('vm:entry-point')
  static Future<void> createNewNotification(RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecond,
          channelKey: 'alarm_channel',
          title: message.data["title"],
          body: message.data["body"],
          category: NotificationCategory.Alarm,
          autoDismissible: true,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'SNOOZE',
            label: 'SNOOZE',
            color: Colors.blue,
            actionType: ActionType.Default,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'STOP',
            label: 'STOP',
            color: Colors.blue,
            actionType: ActionType.SilentAction,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'DISMIS',
            label: 'DISMIS',
            color: Colors.red,
            actionType: ActionType.SilentBackgroundAction,
            autoDismissible: true,
          ),
        ]);
  }

  static Future<void> resetBadgeCounter() async {
    await AwesomeNotifications().resetGlobalBadge();
  }

  static Future<void> cancelNotifications() async {
    await AwesomeNotifications().cancelAll();
  }
}
