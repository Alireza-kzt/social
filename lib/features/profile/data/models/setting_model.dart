import 'package:get/get.dart';
import 'package:taakitecture/taakitecture.dart';

enum ActivityStatus {off, on, disable}

class SettingModel extends BaseModel with ModelMixin {
  late Rx<ActivityStatus> activity;
  late Rx<ActivityStatus> activation;

  @override
  BaseModel getInstance() => SettingModel();

  @override
  Map<String, dynamic> get properties => {
        "isOnline" : activity.value == ActivityStatus.on,
        "isShowInApp" : activation.value == ActivityStatus.on,
  };

  bool get isActive => activation.value == ActivityStatus.on;

  bool get isOnline => activity.value == ActivityStatus.on;

  @override
  void setProp(String key, value) {
    switch (key) {
      case "isOnline":
        activity = ActivityStatus.values[value].obs;
        break;
      case "isShowInApp":
        activation = ActivityStatus.values[value].obs;
        break;
    }
  }
}
