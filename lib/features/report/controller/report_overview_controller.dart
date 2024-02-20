import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/features/report/data/models/report_overview_model.dart';
import 'package:taakitecture/taakitecture.dart';

class ReportOverviewController extends BaseController<ReportOverviewModel> {
  AppDateTime fromDate = AppDateTime.today().addDays(-7);
  AppDateTime toDate = AppDateTime.today();

  ReportOverviewController(super.remoteRepository);

  static ReportOverviewController get to => Get.find();

  @override
  void onInit() => getReportOverview();

  getReportOverview() async => find('${fromDate.toServerString()}/${toDate.toServerString()}');
}