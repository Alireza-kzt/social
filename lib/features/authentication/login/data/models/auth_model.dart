import 'package:taakitecture/taakitecture.dart';

class AuthModel extends BaseModel {
  bool? hasPassword;
  bool? valid;

  @override
  fromJson(Map<String, dynamic> json) {
    hasPassword = json['hasPassword'];
    valid = json['valid'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {'hasPassword': hasPassword};
}
