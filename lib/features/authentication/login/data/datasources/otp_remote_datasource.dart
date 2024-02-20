import 'package:taakitecture/taakitecture.dart';

import '../../../../../core/app/constants/api_paths.dart';
import '../models/register_otp_result_model.dart';

class OtpRemoteDataSource extends BaseRemoteDatasource {
  OtpRemoteDataSource(IClient client)
      : super(
          client: client,
          model: RegisterOtpResultModel(),
          path: ApiPaths.otp,
        );
}
