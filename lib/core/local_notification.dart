import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;



class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
  static Future init() async{
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => null);

    final LinuxInitializationSettings initializationSettingsLinux = LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) => null
        );
  }

  // show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound('adhan'),
        ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show( 0, title, body, notificationDetails, payload: payload);
  }

   // show a periodique notification
  static Future showPeriodicNotification({
    required String title,
    required String body,
    required String payload
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel 2', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow( 1, title, body, RepeatInterval.daily, notificationDetails);
  }

  // sechdule notification
  static Future sechduleNotification({
    required String title,
    required String body,
    required String payload,
    required tz.TZDateTime scheduledTime 
  })async{
    tz.initializeTimeZones();
    var localTime = tz.local;
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your channel 3', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('adhan/adhen-tounes-ali-barek.mp3'),
        priority: Priority.high,
        ticker: 'ticker');
    // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5))
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(2, title, body,scheduledTime,
     notificationDetails, androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
   
  }

  // close a specific notification channel
  static Future cancel(int id) async{
    await flutterLocalNotificationsPlugin.cancel(id);
  }
  // close all notifications
  static Future cancelAll() async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}