import 'package:social/features/messenger/data/datasources/file_datasource.dart';
import 'package:social/features/messenger/data/repositories/file_repository.dart';
import 'package:social/features/profile/data/datasource/setting_remote_datasource.dart';
import 'package:taakitecture/taakitecture.dart';
import 'controller/activation_profile_controller.dart';
import 'controller/edit_profile_controller.dart';
import 'controller/profile_controller.dart';
import 'controller/upload_profile_controller.dart';
import 'data/datasource/profile_datasource.dart';
import 'data/repository/profile_repository.dart';
import 'data/repository/setting_repository.dart';

class ProfileBindings extends Injection {
  @override
  initController() {
    singleton(ProfileController(sl<ProfileRepository>()));
  }

  @override
  initDataSource() {
    singleton(ProfileDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ProfileRepository(sl<ProfileDatasource>(), sl()));
  }
}

class SettingBindings extends Injection {
  @override
  initController() {
    singleton(ActivationProfileController(sl<SettingRepository>()));
  }

  @override
  initDataSource() {
    singleton(SettingRemoteDataSource(sl()));
  }

  @override
  initRepository() {
    singleton(SettingRepository(sl<SettingRemoteDataSource>(), sl()));
  }
}

class EditProfileBindings extends Injection {
  @override
  initController() {
    singleton(EditProfileController(sl<ProfileRepository>()));
  }

  @override
  initDataSource() {
    singleton(ProfileDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(ProfileRepository(sl<ProfileDatasource>(), sl()));
  }
}

class UploadProfileBindings extends Injection {
  @override
  initController() {
    singleton(UploadProfileController(sl<FileRepository>()));
  }

  @override
  initDataSource() {
    singleton(FileRemoteDatasource(sl()));
  }

  @override
  initRepository() {
    singleton(FileRepository(sl<FileRemoteDatasource>(), sl()));
  }
}
