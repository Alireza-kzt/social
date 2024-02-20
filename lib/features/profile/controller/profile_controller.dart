import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/core/features/scaffold/controller/app_scaffold_controller.dart';
import 'package:taakitecture/taakitecture.dart';
import '../data/models/profile_model.dart';

class ProfileController extends BaseController<ProfileModel> {
  ProfileController(super.remoteRepository);

  static ProfileController get to => Get.find();

  @override
  void onInit() => getProfile();

  getProfile() => find();

  editProfile(ProfileModel profileModel) async {
    final result = await Get.toNamed(AppRoutes.editProfile, arguments: profileModel);
    if (result == true) {
      getProfile();
    }
  }

  @override
  onSuccess(ProfileModel result) {
    if (result.avatarImage != null) {
      AppScaffoldController.to.setProfileImage(result.avatarImage!);
    }

    return super.onSuccess(result);
  }
}
