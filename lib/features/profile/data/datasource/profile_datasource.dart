import 'package:social/core/app/constants/api_paths.dart';
import 'package:taakitecture/taakitecture.dart';
import '../models/profile_model.dart';

class ProfileDatasource extends BaseRemoteDatasource {
  ProfileDatasource(IClient client)
      : super(
          client: client,
          model: ProfileModel(),
          path: ApiPaths.profile,
        );
}
