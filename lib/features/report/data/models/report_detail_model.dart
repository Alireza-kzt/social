import 'package:taakitecture/taakitecture.dart';
import 'point_model.dart';

class ReportDetailModel extends BaseModel with ModelMixin {
  late List<PointModel> activities;
  late double total;
  late double progress;

  @override
  BaseModel getInstance() => ReportDetailModel();

  @override
  Map<String, dynamic> get properties => {};

  @override
  void setProp(String key, value) {
    switch (key) {
      case "total":
        total = value.toDouble();
        break;
      case "progress":
        progress = value;
        break;
      case "activities":
        activities = [for (var mapJson in value) PointModel().fromJson(mapJson)];
        break;
    }
  }
}
