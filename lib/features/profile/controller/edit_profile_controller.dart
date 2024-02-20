import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/features/profile/data/models/profile_model.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../core/app/utils/mixin/handle_failure_mixin.dart';

class EditProfileController extends BaseController with HandleFailureMixin {
  ProfileModel model = Get.arguments;
  late TextEditingController usernameTextEditingController;
  late TextEditingController expertiseTextEditingController;
  late TextEditingController medicalNumberTextEditingController;
  late TextEditingController biographyTextEditingController;

  EditProfileController(super.remoteRepository);

  static EditProfileController get to => Get.find();

  @override
  onInit() {
    usernameTextEditingController = TextEditingController(text: model.username);
    expertiseTextEditingController = TextEditingController(text: model.expertise);
    medicalNumberTextEditingController = TextEditingController(text: model.medicalNumber);
    biographyTextEditingController = TextEditingController(text: model.biography);

    super.onInit();
  }

  editProfile([String? avatar]) {
    model.username = usernameTextEditingController.text;
    model.expertise = expertiseTextEditingController.text;
    model.medicalNumber = medicalNumberTextEditingController.text;
    model.biography = biographyTextEditingController.text;
    model.avatarImage = avatar ?? model.avatarImage;

    edit(model: model);
  }

  @override
  onSuccess(result) {
    Get.back(result: true);
    return super.onSuccess(result);
  }
}
