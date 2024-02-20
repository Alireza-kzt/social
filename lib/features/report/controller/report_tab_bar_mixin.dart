import 'package:get/get.dart';

import '../../../core/app/utils/classes/app_datetime.dart';

mixin ReportTabBarMixin {
  late Rx<AppDateTime> selectedValue = tabs.first.value.obs;

  onValueChanged(AppDateTime value) => selectedValue.value = value;

  List<({String label, AppDateTime value})> get tabs => [
        (
          label: 'هفتگی',
          value: AppDateTime.today().addDays(-6),
        ),
        (
          label: 'ماهانه',
          value: AppDateTime.today().addMonths(-1),
        ),
        (
          label: '3 ماهه',
          value: AppDateTime.today().addMonths(-3),
        ),
      ];

  String get currentLabel => tabs.firstWhere((element) => element.value == selectedValue.value).label;
}
