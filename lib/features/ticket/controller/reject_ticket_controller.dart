import 'package:get/get.dart';
import 'package:social/features/ticket/controller/ticket_interface.dart';

class RejectTicketsController extends TicketInterface {

  RejectTicketsController(super.remoteRepository);

  static RejectTicketsController get to => Get.find();

  @override
  String get path => 'reject';

  @override
  String get emptyText => 'هیچ تیکت رد شده ای وجود نداره';

  @override
  String get title => 'سوالات رد شده';
}
