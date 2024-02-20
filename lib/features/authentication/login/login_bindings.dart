import 'package:taakitecture/taakitecture.dart';

import 'controller/login_controller.dart';
import 'controller/new_password_controller.dart';
import 'controller/register_number_controller.dart';
import 'controller/resend_code_controller.dart';
import 'controller/verify_code_controller.dart';
import 'data/datasources/login_remote_datasource.dart';
import 'data/datasources/new_password_datasource.dart';
import 'data/datasources/otp_remote_datasource.dart';
import 'data/repositories/login_repository.dart';
import 'data/repositories/new_password_repository.dart';
import 'data/repositories/otp_remote_repository.dart';

class LoginBindings extends Injection {
  @override
  initController() {
    singleton(LoginController(sl<LoginRepository>()));
  }

  @override
  initDataSource() {
    singleton(LoginRemoteDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(LoginRepository(sl<LoginRemoteDatasource>(), sl()));
  }
}
class RegisterOtpBindings extends Injection {
  @override
  initController() {
    singleton(RegisterNumberController(sl<OtpRemoteRepository>()));
  }

  @override
  initDataSource() {
    singleton(OtpRemoteDataSource(sl()));
  }

  @override
  initRepository() {
    singleton(OtpRemoteRepository(sl<OtpRemoteDataSource>(), sl()));
  }
}


class VerifyCodeBindings extends Injection {
  @override
  initController() {
    singleton(VerifyCodeController(sl<OtpRemoteRepository>()));
    singleton(ResendCodeController(sl<OtpRemoteRepository>()));
  }

  @override
  initDataSource() {
    singleton(OtpRemoteDataSource(sl()));
  }

  @override
  initRepository() {
    singleton(OtpRemoteRepository(sl<OtpRemoteDataSource>(), sl()));
  }
}

class NewPasswordBindings extends Injection {
  @override
  initController() {
    singleton(NewPasswordController(sl<NewPasswordRepository>()));
  }

  @override
  initDataSource() {
    singleton(NewPasswordDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(NewPasswordRepository(sl<NewPasswordDatasource>(), sl()));
  }
}

