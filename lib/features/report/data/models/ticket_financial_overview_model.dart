import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:taakitecture/taakitecture.dart';
import 'ticket_overview_item_model.dart';

class TicketFinancialOverviewModel extends BaseModel with ModelMixin {
  late AppDateTime datetime;
  late List<TicketFinancialOverviewItemModel> items;

  @override
  BaseModel getInstance() => TicketFinancialOverviewModel();

  @override
  Map<String, dynamic> get properties => {
        "datetime" : datetime,
        "items" : [for(var model in items) model.toJson()],
  };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "items":
        items = [for(var mapJson in value) TicketFinancialOverviewItemModel().fromJson(mapJson)];
        break;
      case "datetime":
        datetime = AppDateTime.parse(value);
        break;
    }
  }
}
