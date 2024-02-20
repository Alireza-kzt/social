import 'package:get/get.dart';

import '../../../features/scaffold/data/models/tab_model.dart';

mixin NavigationMixin on GetxController, StateMixin {
  List<TabModel> get tabs;
  RxInt get index;

  @override
  onInit() {
    change(tabs[index.value].page, status: RxStatus.success());
    ever(index, refreshTab);
    super.onInit();
  }

  setIndex(int i) => index.value = i;

  TabModel get currentTab => tabs[index.value];

  refreshTab(int i) {
    tabs[i].action?.call();
    change(tabs[i].page, status: RxStatus.success());
  }
}
