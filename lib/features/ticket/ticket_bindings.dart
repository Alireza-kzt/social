import 'package:taakitecture/taakitecture.dart';

import 'controller/closed_ticket_controller.dart';
import 'controller/open_ticket_controller.dart';
import 'controller/reject_ticket_controller.dart';
import 'controller/tickets_controller.dart';
import 'data/datasource/ticket_remote_datasource.dart';
import 'data/repository/ticket_repository.dart';

class TicketBindings extends Injection {
  @override
  initController() {
    singleton(ClosedTicketsController(sl<TicketRepository>()));
    singleton(OpenTicketsController(sl<TicketRepository>()));
    singleton(RejectTicketsController(sl<TicketRepository>()));
    singleton(TicketsController());
  }

  @override
  initDataSource() {
    singleton(TicketsRemoteDataSource(sl()));
  }

  @override
  initRepository() {
    singleton(TicketRepository(sl<TicketsRemoteDataSource>(), sl()));
  }
}
