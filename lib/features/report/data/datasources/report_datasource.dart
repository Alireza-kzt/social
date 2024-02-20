import 'package:social/core/app/constants/api_paths.dart';
import 'package:taakitecture/taakitecture.dart';
import '../models/report_model.dart';

class ReportDatasource extends BaseRemoteDatasource {
  ReportDatasource(IClient client)
      : super(
          client: client,
         model: ReportModel(),
         path: ApiPaths.report,
        );
}
