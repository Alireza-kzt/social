import 'package:social/features/ticket/data/models/ticket_item_model.dart';
import 'package:taakitecture/taakitecture.dart';

class TicketModel extends BaseModel with ModelMixin {
  late int totalCount;
  late List<TicketItemModel> items;

  @override
  BaseModel getInstance() => TicketModel();

  @override
  Map<String, dynamic> get properties => {
        "totalCount": totalCount,
        "items": [for (var item in items) item.toJson()]
      };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "items":
        items = [for (var item in value) TicketItemModel().fromJson(item)];
        break;
      case "totalCount":
        totalCount = value;
        break;
    }
  }
}
