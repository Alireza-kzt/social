import 'package:get/get.dart';
import '../../../app.dart';
import '../../../app/constants/app_routes.dart';
import '../../../app/utils/helper/box_helpers.dart';

class SplashController extends GetxController {
  String route = AppRoutes.splash;

  @override
  onInit() async {
    await App.init();
    await Future.delayed(const Duration(milliseconds: 500));
    bool isLogged = BoxHelper.hasToken;
    fireRoute(isLogged);

    super.onInit();
  }

  fireRoute(bool logged) {
    if (logged) {
      Get.offNamed(route = AppRoutes.root);
    } else {
      Get.offNamed(route = AppRoutes.login);
    }
  }
}
