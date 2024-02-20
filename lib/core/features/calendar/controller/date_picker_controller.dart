import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DatePickerController extends GetxController {
  Jalali fromDate = Jalali.min;
  Jalali toDate = Jalali.min;
  final List<List<Jalali>> calendarItems;
  final ItemScrollController itemScrollController = ItemScrollController();
  final int initialIndex = 12;
  final double initialAlignment = 0.2;
  bool isSelectingStart = true;

  DatePickerController(Jalali fromDate, Jalali toDate) : calendarItems = toListOfMonth([for (var date = fromDate; date <= toDate; date = date.addDays(1)) date]);

  onDatePressed(Jalali date) {
    if (isSelectingStart) {
      fromDate = date;
      toDate = date;
      isSelectingStart = false;
    } else if (date < fromDate) {
      fromDate = date;
      toDate = date;
    } else {
      toDate = date;
      isSelectingStart = true;
    }

    update();
  }

  bool isInRange(Jalali date) => fromDate <= date && date <= toDate;

  onSubmit() => Get.back(result: (fromDate.toDateTime(), toDate.toDateTime()));

  onCancel() => Get.back();

  static List<List<Jalali>> toListOfMonth(List<Jalali> calendarItems) {
    late int monthLength;
    final List<List<Jalali>> items = [];

    for (int dayIndex = 0; dayIndex < calendarItems.length; dayIndex += monthLength) {
      Jalali firstDay = calendarItems[dayIndex];
      monthLength = firstDay.monthLength;
      int remainLength = calendarItems.length - dayIndex;
      int toDayIndex = remainLength < monthLength ? dayIndex + remainLength : dayIndex + monthLength;
      items.add(calendarItems.sublist(dayIndex, toDayIndex));
    }

    return items;
  }
}
