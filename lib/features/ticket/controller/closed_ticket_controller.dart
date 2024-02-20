import 'package:get/get.dart';
import 'package:social/features/ticket/controller/ticket_interface.dart';

class ClosedTicketsController extends TicketInterface {
  ClosedTicketsController(super.remoteRepository);

  static ClosedTicketsController get to => Get.find();

  @override
  String get path => 'close';

  @override
  String get emptyText => 'هیچ تیکت پاسخ کاملی وجود نداره';

  @override
  String get title => 'سوالات پاسخ کامل';
}
