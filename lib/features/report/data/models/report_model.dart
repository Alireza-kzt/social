import 'package:social/features/report/data/models/ticket_financial_overview_model.dart';
import 'package:taakitecture/taakitecture.dart';
import 'comment_model.dart';
import 'report_detail_model.dart';

class ReportModel extends BaseModel with ModelMixin {
  late ReportDetailModel reportDetail;
  late int totalCount;
  late List<CommentModel> comments;
  late List<TicketFinancialOverviewModel> finances;

  @override
  BaseModel getInstance() => ReportModel();

  @override
  Map<String, dynamic> get properties => {"comments": comments};

  @override
  void setProp(String key, value) {
    switch (key) {
      case "report":
        reportDetail = ReportDetailModel().fromJson(value);
        break;
      case "comments":
        comments = [for (var mapJson in value) CommentModel().fromJson(mapJson)];
        break;
      case "totalCommentCount":
      case "totalFinanceCount":
        totalCount = value;
        break;
      case "finances":
        finances = [for (var mapJson in value) TicketFinancialOverviewModel().fromJson(mapJson)];
        break;
    }
  }
}
