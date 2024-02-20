import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'app/config/app_setting.dart';

class App {
  static AppLinks appLinks = AppLinks();
  static GetStorage box = GetStorage();
  static Logger logger = Logger(
    printer: PrettyPrinter(
      printEmojis: false,
      printTime: false,
      methodCount: 0,
      noBoxingByDefault: true,
    ),
  );

  static Future init() async {
    await initBox();
  }

  static onAppStart(BuildContext context) {
    SystemChrome.setPreferredOrientations(AppSetting.orientation); // Lock orientate
  }

  static Future initBox() async {
    await GetStorage.init();
    box = GetStorage();
  }

  static Future initDeepLink() async {
    try {
      appLinks.uriLinkStream.listen(onLinking);
      debugPrint('*** => Deep linking listener initialized.');
    } catch (_) {
      debugPrint('*** => Deep linking listener initialization failed.');
    }
  }

  static void onLinking(Uri uri) {
    try {
      Get.toNamed(uri.path, parameters: uri.queryParameters);
      debugPrint('*** => Deep link navigated to $uri.');
    } catch (_) {
      debugPrint('*** => Deep linking navigated to $uri failed.');
    }
  }
}
