import 'package:taakitecture/taakitecture.dart';

import '../../../../core/app/constants/api_paths.dart';
import '../models/ticket_model.dart';

class TicketsRemoteDataSource extends BaseRemoteDatasource {
  TicketsRemoteDataSource(IClient client)
      : super(
          client: client,
         model: TicketModel(),
         path: ApiPaths.tickets,
        );
}
