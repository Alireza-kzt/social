import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/model/record_model.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:taakitecture/taakitecture.dart';

import '../../../../core/app/constants/app_routes.dart';
import '../../../../core/app/constants/messages.dart';
import '../../../../core/app/utils/classes/validation.dart';
import '../../../../core/app/view/widgets/toast.dart';

class RegisterNumberController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberTextEditingController = TextEditingController();

  RegisterNumberController(super.remoteRepository);

  static RegisterNumberController get to => Get.find();


  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  onNextStepPressed() {
    if (formKey.currentState!.validate()) {
      change(null, status: RxStatus.loading());
      return sendCode();
    }
  }

  sendCode() => edit(model: RecordeModel([('identity', phoneNumberTextEditingController.text)]));

  @override
  onSuccess(result) {
    if(result.valid) {
      Get.toNamed(AppRoutes.verifyCode, arguments: phoneNumberTextEditingController.text);
    } else {
      toast(message: 'ثبت نام نشده');
    }
    super.onSuccess(result);
  }

  @override
  onFailure(String requestId, Failure failure, Function action) {
    change(null, status: RxStatus.success());
    toast(message: Messages.serverFailureTitle, snackPosition: SnackPosition.TOP);
  }

  onNumberChanged(String? value) {
    Validation.phoneNumberValidator(
      value,
      onEmpty: () {
        change(null, status: RxStatus.empty());
      },
      onNotValidPrefix: () {
        change(null, status: RxStatus.empty());
      },
      onNotValidLength: () {
        change(null, status: RxStatus.empty());
      },
      onSuccess: () {
        change(null, status: RxStatus.success());
      },
    );
  }

  String? phoneNumberValidation(String? value) {
    return Validation.phoneNumberValidator(
      value,
      onNotValidPrefix: () => Messages.phoneNumberErrorNotValidPrefix,
      onEmpty: () => Messages.phoneNumberErrorEmpty,
      onNotValidLength: () => Messages.phoneNumberErrorNotValidLength,
    );
  }
}
