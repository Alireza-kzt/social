import 'package:social/features/report/controller/report_controller.dart';
import '../data/models/report_model.dart';

class FinancialReportController extends ReportController {
  @override
  String get path => 'finance';

  FinancialReportController(super.remoteRepository);

  @override
  onSuccess(ReportModel result) {
    items.addAll(result.finances);
    return super.onSuccess(result);
  }
}
