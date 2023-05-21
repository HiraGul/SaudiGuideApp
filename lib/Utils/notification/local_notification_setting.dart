import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationSetting {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    dynamic id,
    String? title,
    String? payload,
    String? body,
    required DateTime scheduleDate,
  }) async {
    tz.initializeTimeZones();
    _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(),
        payload: payload,

        ///this is for daily notification.
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future init() async {
    //const iOS = IOSInitializationSettings();
    const DarwinInitializationSettings iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentSound: true,
    );
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");

    // ignore: prefer_const_declarations
    final setting = const InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(setting,
        onDidReceiveNotificationResponse: ((response) {
      if (response.payload!.isNotEmpty) {
        print(response.payload);
      }
    }));
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel Id',
        'Channel Name',
        channelDescription: 'Channel Description',
        visibility: NotificationVisibility.public,

        ticker: 'yes',
        channelShowBadge: true,
        enableLights: true,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        importance: Importance.max,
        icon: '@mipmap/ic_launcher',
        // sound: RawResourceAndroidNotificationSound('azaan'),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  /// just pass the channel id of the notification
  static Future removeSingleNotifications({required int? id}) async =>
      await _notifications.cancel(id!);

  /// To Remove All Notifications
  static Future removeAllNotifications() async =>
      await _notifications.cancelAll();

  static DateTime futureTime(DateTime sheduledate) {
    if (sheduledate.isBefore(DateTime.now())) {
      sheduledate = sheduledate.add(const Duration(days: 1));
    }
    return sheduledate;
  }
}
