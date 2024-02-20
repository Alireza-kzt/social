import 'package:taakitecture/taakitecture.dart';

class RegisterOtpResultModel extends BaseModel with ModelMixin {
  late bool valid;
  late String token;

  @override
  BaseModel getInstance() => RegisterOtpResultModel();

  @override
  Map<String, dynamic> get properties => {
        'valid': valid,
        'token': token,
      };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "valid":
        valid = value ?? true;
        break;
      case "token":
        token = value;
        break;
    }
  }
}
