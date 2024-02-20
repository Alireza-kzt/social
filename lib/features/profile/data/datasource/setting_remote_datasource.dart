import 'package:social/features/profile/data/models/setting_model.dart';
import 'package:taakitecture/taakitecture.dart';

import '../../../../core/app/constants/api_paths.dart';

class SettingRemoteDataSource extends BaseRemoteDatasource {
  SettingRemoteDataSource(IClient client)
      : super(
          client: client,
         model: SettingModel(),
         path: ApiPaths.setting,
        );
}
