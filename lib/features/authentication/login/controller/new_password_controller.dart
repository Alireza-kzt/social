import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/core/app/view/widgets/toast.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../../core/app/model/record_model.dart';

class NewPasswordController extends BaseController {
  TextEditingController repeatPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  final String identity = Get.arguments;
  final formKey = GlobalKey<FormState>();

  NewPasswordController(super.baseRemoteRepository);

  static NewPasswordController get to => Get.find();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void changePassword() {
    if(formKey.currentState!.validate()) {
      if (password.text == repeatPassword.text) {
        create(model: RecordeModel([('identity', identity), ('password', password.text)]));
      } else {
        toast(message: 'رمز عبور و تکرار رمز عبور متفوت است.');
      }
    }
  }

  @override
  onSuccess(result) {
    if(result.valid) {
      Get.offAllNamed(AppRoutes.login);
    }

    return super.onSuccess(result);
  }
}