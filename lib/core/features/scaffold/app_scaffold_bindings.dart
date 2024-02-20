import 'package:taakitecture/taakitecture.dart';
import 'controller/app_scaffold_controller.dart';

class AppScaffoldBindings extends Injection {
  @override
  initController() {
    singleton(AppScaffoldController());
  }

  @override
  initDataSource() {}

  @override
  initRepository() {}
}
