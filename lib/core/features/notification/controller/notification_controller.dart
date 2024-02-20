import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/api_paths.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/features/messenger/controller/messenger_controller.dart';
import 'package:social/features/ticket/controller/tickets_controller.dart';
import 'package:social/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../app.dart';
import '../../../app/utils/helper/box_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../view/pages/notification_page.dart';

class NotificationController extends BaseController {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationController(super.remoteRepository);

  static init() async {
    await initLocalNotification();
    await initFirebaseNotifications();
    subscribeNotifications();

    final notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      await onDidReceiveNotification(notificationAppLaunchDetails!.notificationResponse!);
      debugPrint('*** => onDidReceiveNotification was call after open app by notification.');
    }
  }

  static Future initLocalNotification() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );
  }

  static Future initFirebaseNotifications() async {
    debugPrint('*** =>  Initialize firebase...');
    try {
      debugPrint('*** => Firebase initialized');
      debugPrint('*** =>  Initialize FCM...');
      await FirebaseMessaging.instance.getToken().then(
        (token) async {
          await App.initBox();
          onRefreshToken(token ?? '');
          debugPrint('*** => FIREBASE MESSAGING Token => $token');
        },
      );

      FirebaseMessaging.instance.onTokenRefresh.listen(onRefreshToken);
    } catch (e) {
      debugPrint('*** => FCM initialization failed!');
    }
  }

  static subscribeNotifications() {
    if(!kIsWeb) FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) => showNotification(message));
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // await Firebase.initializeApp();
    await initLocalNotification();
    return showNotification(message);
  }

  static Future<void> showNotification(RemoteMessage message) async {
    showLocalNotification(
      message.data['id'],
      message.data['title'],
      message.data['body'],
      message.data['image'],
      message.data,
      null,
    );
  }

  static Future<Uint8List> _getByteArrayFromUrl(String? url) async {
    if (url == null || url.isEmpty) return Future.value(Uint8List.fromList([]));

    final response = await Dio().get<List<int>>(url, options: Options(responseType: ResponseType.bytes));

    return Uint8List.fromList(response.data ?? []);
  }

  static Future showLocalNotification(
    String id,
    String? title,
    String? body,
    String? imageUrl,
    Map<String, dynamic>? payload,
    String? channelId,
  ) async {
    StyleInformation styleInformation = const DefaultStyleInformation(true, true);

    if (imageUrl != null && imageUrl.isNotEmpty) {
      final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(imageUrl));
      styleInformation = BigPictureStyleInformation(bigPicture);
    }

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId ?? 'GeneralNotificationChannelId',
      'GeneralNotificationChannel',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: styleInformation,
    );

    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    Map<String, dynamic> payloadJson = json.decode(payload?['payload']);

    if (Get.currentRoute.split('?').first == AppRoutes.chat &&
        payloadJson['ticketId'] != null &&
        MessengerController.to.ticketId == payloadJson['ticketId']) {
      MessengerController.to.getAllMessage();
    } else {
      if (Get.currentRoute == AppRoutes.root) {
        TicketsController.to.initTickets();
      }

      flutterLocalNotificationsPlugin.show(
        int.parse(id),
        title ?? '',
        body ?? '',
        platformChannelSpecifics,
        payload: json.encode(payload),
      );
    }
  }

  @pragma('vm:entry-point')
  static Future<void> onDidReceiveNotification(NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      final payload = jsonDecode(notificationResponse.payload!);
      debugPrint('*** => on select notification payload: $payload');

      if (payload['redirect'] != null) {
        if (await launchUrl(Uri.parse(payload['redirect']))) {
          debugPrint('*** => Notification reaction launchUrl ${payload['redirect']}.');
        } else {
          debugPrint('*** => Notification reaction failed to launchUrl ${payload['redirect']}.');
        }
      }

      Map<String, dynamic> payloadJson = json.decode(payload['payload']);
      if (payloadJson['ticketId'] != null) {
        final uri = Uri(scheme: 'impodoctor', host: 'page', path: AppRoutes.chat, queryParameters: {'id': payloadJson['ticketId']});
        await launchUrl(uri);
      }
    }
  }

  static requestPermission() async => FirebaseMessaging.instance.requestPermission().then((value) async => Get.back());

  static showDialogIfHasNotPermission() async {
    NotificationSettings setting = await FirebaseMessaging.instance.getNotificationSettings();

    if (!BoxHelper.isNotificationPermissionSeen && setting.authorizationStatus != AuthorizationStatus.authorized) {
      await NotificationPage.showBottomSheet();
      BoxHelper.setNotificationPermissionSeen();
    }

    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      NotificationController.init();
    }
  }

  static Future<void> onRefreshToken(String token) async {
    await BoxHelper.setFirebaseMessagingToken(token);
    Get.find<IClient>().post(ApiPaths.token, data: {'token': token});
  }
}
