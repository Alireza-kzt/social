import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/view/widgets/toast.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../../core/app/constants/app_routes.dart';
import '../../../../core/app/utils/helper/box_helpers.dart';
import '../../../../core/app/view/widgets/snackbar/snackbar.dart';
import '../data/models/login_model.dart';

class LoginController extends BaseController {
  SnackbarController? snackbarController;
  final formKey = GlobalKey<FormState>();
  final TextEditingController userIdentityTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  LoginController(super.remoteRepositor);

  static LoginController get to => Get.find<LoginController>();

  @override
  void onInit() {
    change(null, status: RxStatus.success());

    super.onInit();
  }

  setIdentity() async {
    if (formKey.currentState?.validate() ?? false) {
      return create(
          model: LoginModel()
            ..username = userIdentityTextEditingController.text
            ..password = passwordTextEditingController.text);
    }
  }

  @override
  onSuccess(result) async {
    if (result.valid) {
      Get.focusScope?.unfocus();
      BoxHelper.setToken(result.token);
      Get.offAllNamed(AppRoutes.root);
    } else {
      toast(message: 'نام کاربری یا رمز عبور اشتباه است.');
    }

    super.onSuccess(result);
  }

  @override
  onFailure(String requestId, Failure failure, Function action) {
    snackbarController?.close();
    change(null, status: RxStatus.success());
    snackbarController = Snackbar.serviceFailure(retry: () => action());
  }

  @override
  onLoading() {
    snackbarController?.close();
    return super.onLoading();
  }

  @override
  void dispose() async {
    snackbarController?.close();
    super.dispose();
  }

  void forgotPassword() => Get.toNamed(AppRoutes.number);
}
