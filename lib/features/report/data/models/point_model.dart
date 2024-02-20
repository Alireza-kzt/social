import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:taakitecture/taakitecture.dart';

class PointModel extends BaseModel with ModelMixin {
  late int x;
  late double y;
  late String label;
  late AppDateTime dateTime;

  @override
  BaseModel getInstance() => PointModel();

  @override
  Map<String, dynamic> get properties => {
        "x": x,
        "y": y,
        "label": label,
        "dateTime": dateTime.toServerString(),
      };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "x":
        x = value.toInt();
        break;
      case "y":
        y = value.toDouble();
        break;
      case "label":
        label = value;
        break;
      case "dateTime":
        dateTime = AppDateTime.parse(value);
        break;
    }
  }
}
