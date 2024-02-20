import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:taakitecture/taakitecture.dart';

enum TicketStatus {
  pending,
  answered,
  needYourAnswer,
  closed,
  rejected,
  noPay,
  forceClose,
  none
}

class TicketItemModel extends BaseModel with ModelMixin {
  late String id;
  late String username;
  late String text;
  late AppDateTime createTime;
  late TicketStatus ticketStatus;

  @override
  BaseModel getInstance() => TicketItemModel();

  @override
  Map<String, dynamic> get properties => {
        "id": id,
        "username": username,
        "text": text,
        "createTime": createTime.toServerString(),
        "ticketState": ticketStatus,
      };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "id":
        id = value;
        break;
      case "userName":
        username = value;
        break;
      case "text":
        text = value;
        break;
      case "createTime":
        createTime = AppDateTime.parse(value);
        break;
      case "status":
        ticketStatus = TicketStatus.values[value];
        break;
    }
  }
}
