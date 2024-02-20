import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social/core/app/utils/mixin/handle_failure_mixin.dart';
import 'package:social/features/report/controller/report_overview_controller.dart';
import 'package:social/features/report/controller/report_tab_bar_mixin.dart';

import '../../../core/app/utils/classes/app_datetime.dart';

class TicketReportController extends ReportOverviewController with ReportTabBarMixin, HandleFailureMixin {
  TicketReportController(super.remoteRepository);

  static TicketReportController get to => Get.find();

  @override
  onValueChanged(AppDateTime value) {
    fromDate = value;
    getReportOverview();
    super.onValueChanged(value);
  }
}
