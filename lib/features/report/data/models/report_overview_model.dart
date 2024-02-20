import 'package:social/features/report/data/models/report_detail_model.dart';
import 'package:taakitecture/taakitecture.dart';

class ReportOverviewModel extends BaseModel with ModelMixin {
  late ReportDetailModel rate;
  late ReportDetailModel financial;
  late ReportDetailModel ticket;

  @override
  BaseModel getInstance() => ReportOverviewModel();

  @override
  Map<String, dynamic> get properties => {
        "rate": rate.toJson(),
        "financial": financial.toJson(),
        "ticket": ticket.toJson(),
      };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "rate":
        rate = ReportDetailModel().fromJson(value);
        break;
      case "financial":
        financial = ReportDetailModel().fromJson(value);
        break;
      case "ticket":
        ticket = ReportDetailModel().fromJson(value);
        break;
    }
  }
}
