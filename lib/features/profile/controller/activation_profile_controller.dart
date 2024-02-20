import 'package:get/get.dart';
import 'package:taakitecture/taakitecture.dart';
import '../../../core/app/utils/mixin/handle_failure_mixin.dart';
import '../data/models/setting_model.dart';

enum ActivationStatus { offline, online, deactivated }

class ActivationProfileController extends BaseController<SettingModel> with HandleFailureMixin {
  late SettingModel settingModel;
  bool isFirstLoading = true;

  ActivationProfileController(super.remoteRepository);

  static ActivationProfileController get to => Get.find();

  @override
  void onInit() {
    find();
    super.onInit();
  }

  @override
  onSuccess(result) {
    settingModel = result;
    return super.onSuccess(result);
  }

  void onActivationSwitch(bool value) {
    settingModel.activation.value = settingModel.activation.value == ActivityStatus.off ? ActivityStatus.on : ActivityStatus.off;
    create(model: settingModel);
  }

  void onActivitySwitch(bool value) {
    settingModel.activity.value = settingModel.activity.value == ActivityStatus.off ? ActivityStatus.on : ActivityStatus.off;
    create(model: settingModel);
  }

  @override
  onLoading() {
    if (isFirstLoading) {
      super.onLoading();
      isFirstLoading = false;
    }
  }
}
