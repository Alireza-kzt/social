import 'package:taakitecture/taakitecture.dart';
import 'controller/splash_controller.dart';


class SplashBindings extends Injection {
  @override
  initController() {
    // singleton(SplashController(sl<RegisterRemoteRepository>()));
    singleton(SplashController());
  }

  @override
  initDataSource() {
    // singleton(RegisterRemoteDataSource(sl()));
  }

  @override
  initRepository() {
    // singleton(RegisterRemoteRepository(sl<RegisterRemoteDataSource>(), sl()));
  }
}
