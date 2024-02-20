import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/core/app/utils/mixin/handle_failure_mixin.dart';
import 'package:social/features/report/controller/report_tab_bar_mixin.dart';
import 'package:social/features/report/data/models/report_model.dart';
import 'package:taakitecture/taakitecture.dart';

class ReportController extends BaseController<ReportModel> with ReportTabBarMixin, HandleFailureMixin, ScrollMixin {
  int pageNo = 0;
  final int pageSize = 20;
  bool initialService = true;
  RxBool isPagingOnLoading = false.obs;
  late int totalCount;
  final String path = '/';
  List items = [];

  ReportController(super.remoteRepository);

  static ReportController get to => Get.find();

  @override
  onInit() {
    getReport();

    super.onInit();
  }

  getReport() => find('$path/$pageNo/$pageSize/${selectedValue.value.toServerString()}/${AppDateTime.now().toServerString()}');

  @override
  onLoading() {
    if (initialService) {
      initialService = false;
      return super.onLoading();
    } else {
      isPagingOnLoading.value = true;
    }
  }

  initPage() {
    pageNo = 0;
    initialService = true;
    isPagingOnLoading.value = false;
    items.clear();
  }

  @override
  onValueChanged(AppDateTime value) {
    super.onValueChanged(value);
    initPage();
    getReport();
  }

  @override
  Future<void> onEndScroll() async {
    if (totalCount > (pageNo + 1) * pageSize) {
      pageNo++;
      isPagingOnLoading.value = true;
      getReport();
    }
  }

  @override
  Future<void> onTopScroll() async {}

  @override
  onSuccess(ReportModel result) {
    totalCount = result.totalCount;
    isPagingOnLoading.value = false;

    return super.onSuccess(result);
  }

  void openChat(String chatId) => Get.toNamed(AppRoutes.chat, arguments: chatId);
}
