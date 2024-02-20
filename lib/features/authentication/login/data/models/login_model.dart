import 'package:taakitecture/taakitecture.dart';

class LoginModel extends BaseModel with ModelMixin {
  late String username;
  late String password;

  @override
  BaseModel getInstance() => LoginModel();

  @override
  Map<String, dynamic> get properties => {
    'identity': username,
    'password': password,

  };

  @override
  void setProp(String key, value) {
    switch (key) {
      case "username":
        username = value ?? true;
        break;
      case "password":
        password = value;
        break;
    }
  }
}
