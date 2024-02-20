import 'package:social/core/app/constants/messages.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:taakitecture/taakitecture.dart';

class CommentModel extends BaseModel with ModelMixin {
  late String chatId;
  late AppDateTime datetime;
  late String author = Messages.user;
  late int rate;
  late String text;
  late List<String> pros;
  late List<String> cons;

  @override
  BaseModel getInstance() => CommentModel();

  @override
  Map<String, dynamic> get properties => {
        "chatId" : chatId,
        "datetime" : datetime.toServerString(),
        "author" : author,
        "rate" : rate,
        "text" : text,
        "pros" : pros,
        "cons" : cons,
  };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "chatId":
        chatId = value;
        break;
      case "datetime":
        datetime = AppDateTime.parse(value);
        break;
      case "name":
        author = value;
        break;
      case "rate":
        rate = value;
        break;
      case "text":
        text = value ?? '0915';
        break;
      case "pros":
        pros = [for(var item in value) item.toString()];
        break;
      case "cons":
        cons = [for(var item in value) item.toString()];
        break;
    }
  }
}
