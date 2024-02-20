import 'package:social/features/report/data/models/report_overview_model.dart';
import 'package:taakitecture/taakitecture.dart';

import '../../../../core/app/constants/api_paths.dart';

class ReportOverviewDatasource extends BaseRemoteDatasource {
  ReportOverviewDatasource(IClient client)
      : super(
          client: client,
          model: ReportOverviewModel(),
          path: ApiPaths.report,
        );
}
