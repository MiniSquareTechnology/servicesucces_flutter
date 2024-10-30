import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  saveNotificationData(message);
  AppLogger.logMessage("PREET ----> KK: ${message.data.toString()}");
  // displayIncomingCall();
}

class FirebaseNotifications {
  static checkAppOpen() async {
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // await onSelectNotification(notificationAppLaunchDetails.payload);
    }
  }

  static Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // await initializeApp();
    await setupFlutterNotifications();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
        alert: true, sound: true, badge: true);

    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      saveNotificationData(initialMessage);
      AppLogger.logMessage(
          'Message title:==> ${initialMessage.notification?.title}, body: ${initialMessage.notification?.body}, data: ${initialMessage.data}');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      saveNotificationData(message);
      AppLogger.logMessage(
          'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');
      showFlutterNotification(message);
      // displayIncomingCall();
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      saveNotificationData(event);
      AppLogger.logMessage(
          'Message title:--> ${event.notification?.title}, body: ${event.notification?.body}, data: ${event.data}');
      navigateToJobScreen(event);
    });

    // firebaseMessaging.getAPNSToken().then((value) {
    //   debugPrint('Device APNToken FCM: $value');
    // });


    getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLogger.logMessage("Message title:-->> ${message.toMap()}");
      showNotification(message, false);
    });

    handleForeGroundClick();
  }

  static Future<String?> getToken() async {
   try {
     String? token = await FirebaseMessaging.instance.getToken();
     debugPrint('Device Token FCM: $token');
     AppPreferenceStorage.setStringValuesSF(
         AppPreferenceStorage.fcmToken, token ?? '');
     return token;
   } catch (exception) {
     debugPrint("FCM EE:- ${exception.toString()}");
     return "";
   }
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    AppLogger.logMessage("Message title:-->>>> $id, $title");
  }

  static showNotification(RemoteMessage message, bool showForce) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel.id',
            'channel.name',
            // TODO add a proper drawable resource to android, for now using
            icon: "@mipmap/launcher_icon",
          ),
        ),
      );
    }
    AppLogger.logMessage("Notification ");
  }

  static void handleForeGroundClick() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) {
      navigateInForeGround();
      AppLogger.logMessage(
          "Message title:-->>> ${notificationResponse.notificationResponseType}");
    });
  }

  static navigateInForeGround() async {
    String? token = await AppPreferenceStorage.getStringValuesSF(
        AppPreferenceStorage.authToken);
    if (token == null) {
      return;
    }

    String notificationType = await AppPreferenceStorage.getStringValuesSF(
        AppPreferenceStorage.fcmType) ?? '';
    debugPrint("-=>FF  $notificationType ${Get.currentRoute}");
    /// chat type notification
    if (notificationType.compareTo(AppPreferenceStorage.chatNotification) == 0) {
      String? fcmJobId = await AppPreferenceStorage.getStringValuesSF(
          AppPreferenceStorage.fcmJobId);
      if (fcmJobId != null) {
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.toNamed(RoutePathConstants.historyDetailScreen,
              arguments: {"id": fcmJobId});
        });
      }
    } else if(notificationType.compareTo(AppPreferenceStorage.urlNotification) == 0) {
      String? fcmLinkUrl = await AppPreferenceStorage.getStringValuesSF(
          AppPreferenceStorage.fcmLinkUrl);
      /// url type notification
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.toNamed(RoutePathConstants.webViewScreen,
            arguments: {"url": fcmLinkUrl});
      });
    }

  }
}

void navigateToJobScreen(RemoteMessage event) async {
  String? token = await AppPreferenceStorage.getStringValuesSF(
      AppPreferenceStorage.authToken);
  if (token == null) {
    return;
  }

  Map<String, dynamic> data = event.data;
  String notificationType = data['type'].toString();
  /// chat type notification
  if (notificationType.compareTo(AppPreferenceStorage.chatNotification) == 0) {
    if (data.containsKey('key')) {
      debugPrint("-=>FFF  $data ${Get.currentRoute}");
      Get.toNamed(RoutePathConstants.historyDetailScreen,
          arguments: {"id": data['key']});
    }
  } else if(notificationType.compareTo(AppPreferenceStorage.urlNotification) == 0) {
    /// url type notification
    Get.toNamed(RoutePathConstants.webViewScreen,
          arguments: {"url": data['url']});
  }
}

void saveNotificationData(RemoteMessage event) async {
  String? token = await AppPreferenceStorage.getStringValuesSF(
      AppPreferenceStorage.authToken);
  if (token != null) {
    Map<String, dynamic> data = event.data;
    if (data.containsKey('key')) {
      AppPreferenceStorage.setStringValuesSF(
          AppPreferenceStorage.fcmJobId, data['key']);
    }

    if (data.containsKey('type')) {
      AppPreferenceStorage.setStringValuesSF(
          AppPreferenceStorage.fcmType, data['type']);
    }

    if (data.containsKey('url')) {
      AppPreferenceStorage.setStringValuesSF(
          AppPreferenceStorage.fcmLinkUrl, data['url']);
    }

  }
}

////////////////////////////////////////////////////
Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}
