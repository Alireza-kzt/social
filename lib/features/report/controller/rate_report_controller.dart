import 'package:social/features/report/controller/report_controller.dart';
import '../data/models/report_model.dart';

class RateReportController extends ReportController {
  @override
  String get path => 'rate';

  RateReportController(super.remoteRepository);

  @override
  onSuccess(ReportModel result) {
    items.addAll(result.comments);
    return super.onSuccess(result);
  }
}
