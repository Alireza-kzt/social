import 'package:taakitecture/taakitecture.dart';
import '../../../../../core/app/constants/api_paths.dart';
import '../models/auth_model.dart';

class AuthRemoteDataSource extends BaseRemoteDatasource {
  AuthRemoteDataSource(IClient client)
      : super(
          client: client,
          model: AuthModel(),
          path: ApiPaths.auth,
        );
}
