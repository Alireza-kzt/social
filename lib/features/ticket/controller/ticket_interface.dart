import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/on_datetime/on_datetime.dart';
import 'package:social/core/app/utils/mixin/handle_failure_mixin.dart';
import 'package:social/features/ticket/data/models/ticket_item_model.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:taakitecture/taakitecture.dart';

import '../../../core/features/calendar/controller/date_picker_controller.dart';
import '../../../core/features/calendar/view/widgets/calendar_page.dart';
import '../data/models/ticket_model.dart';

abstract class TicketInterface extends BaseController<TicketModel> with ScrollMixin, HandleFailureMixin {
  late List<TicketItemModel> tickets;
  late int pageNo;
  late int totalCount;
  int pageSize = 20;
  RxBool isPaginationLoading = false.obs;
  bool isInitialLoading = true;

  Rx<(DateTime, DateTime)> dateRange = (Jalali.min.toDateTime(), Jalali.max.toDateTime()).obs;
  RxBool isFiltered = false.obs;

  String get path;

  String get emptyText;

  String get title;

  TicketInterface(super.remoteRepository);

  @override
  Future<void> onInit() async {
    initPaging();
    getTickets();

    super.onInit();
  }

  initPaging() {
    totalCount = double.maxFinite.toInt();
    isPaginationLoading.value = false;
    isFiltered.value = false;
    isInitialLoading = true;
    pageNo = 0;
    tickets = [];
  }

  @override
  Future<void> onEndScroll() async {
    if (totalCount > pageNo * pageSize) {
      pageNo++;
      isPaginationLoading.value = true;
      getTickets();
    }
  }

  @override
  Future<void> onTopScroll() async {}

  Future getTickets() {
    final fromDate = dateRange.value.$1.toServerString();
    final toDate = dateRange.value.$2.toServerString();
    final query = '?fromDate=$fromDate&toDate=$toDate';

    return find('$path/$pageNo/$pageSize${isFiltered.value ? query : ''}');
  }

  @override
  onSuccess(result) {
    totalCount = result.totalCount;
    tickets.addAll(result.items);

    final model = result.copy();
    model.items = tickets;

    if (tickets.isNotEmpty) {
      super.onSuccess(model);
    } else {
      change(result, status: RxStatus.empty());
    }

    isPaginationLoading.value = false;
  }

  @override
  onLoading() {
    if (isInitialLoading) {
      isInitialLoading = false;
      return super.onLoading();
    }
  }

  selectDateRange() async {
    final fromDate = Jalali.now().addYears(-1).withDay(1);
    final toDate = Jalali.now().addMonths(1).withDay(1).addDays(-1);

    final controller = DatePickerController(fromDate, toDate);
    final datetimeRange = await CalendarPage.showBottomSheet(controller);

    if (datetimeRange != null) {
      initPaging();
      dateRange.value = datetimeRange;
      isFiltered.value = true;
      return getTickets();
    }
  }
}
