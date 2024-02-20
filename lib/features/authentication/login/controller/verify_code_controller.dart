import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/features/authentication/login/view/widgets/pin_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../../core/app/constants/app_routes.dart';
import '../../../../core/app/utils/helper/box_helpers.dart';
import '../../../../core/app/view/widgets/snackbar/snackbar.dart';
import '../data/models/register_otp_model.dart';
import '../data/models/register_otp_result_model.dart';

class VerifyCodeController extends BaseController<RegisterOtpResultModel> {
  SnackbarController? snackbarController;
  final String username = Get.arguments;
  TextEditingController pinController = TextEditingController();
  Rx<PinState> pinState = PinState.normal.obs;

  VerifyCodeController(super.remoteRepository);

  static VerifyCodeController get to => Get.find<VerifyCodeController>();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    _initSMSAutoFill();
    super.onInit();
  }

  void _initSMSAutoFill() {
    SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((event) async => pinController.text = event);
  }

  void onPinChanged(String pin) {
    if (pin.length != 5) {
      pinState.value = PinState.normal;
    }
  }

  setIdentity(String token) async {
    RegisterOtpModel tokenModel = RegisterOtpModel();
    tokenModel.identity = username;
    tokenModel.otp = token;
    return create(model: tokenModel);
  }

  @override
  onSuccess(result) async {
    if (result.valid) {
      Get.focusScope?.unfocus();
      pinState.value = PinState.success;
      Get.offAllNamed(AppRoutes.newPassword, arguments: username);
    } else {
      pinState.value = PinState.error;
      Future.delayed(
        const Duration(milliseconds: 1000),
        () => pinController.clear(),
      );
    }
  }

  @override
  onFailure(String requestId, Failure failure, Function action) {
    snackbarController?.close();
    snackbarController = Snackbar.serviceFailure(retry: () => action());
  }

  @override
  onLoading() {
    snackbarController?.close();
    return super.onLoading();
  }

  @override
  void dispose() async {
    await SmsAutoFill().unregisterListener();
    pinController.dispose();
    snackbarController?.close();
    super.dispose();
  }
}
