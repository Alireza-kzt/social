import 'package:get/get.dart';
import 'package:social/features/ticket/controller/ticket_interface.dart';

class OpenTicketsController extends TicketInterface {

  OpenTicketsController(super.remoteRepository);

  static OpenTicketsController get to => Get.find();

  @override
  String get path => 'open';

  @override
  String get emptyText => 'هیچ تیکت بازی وجود نداره';

  @override
  String get title => 'سوالات در جریان';
}
