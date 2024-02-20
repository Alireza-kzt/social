import 'package:taakitecture/taakitecture.dart';

class TicketFinancialOverviewItemModel extends BaseModel with ModelMixin {
  late String title;
  late int amount;
  late String income;

  @override
  BaseModel getInstance() => TicketFinancialOverviewItemModel();

  @override
  Map<String, dynamic> get properties => {
    "title" : title,
    "amount" : amount,
    "income" : income,
  };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "title":
        title = value;
        break;
      case "amount":
        amount = value;
        break;
      case "income":
        income = value;
        break;
    }
  }
}
