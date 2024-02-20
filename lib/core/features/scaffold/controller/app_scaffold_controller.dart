import 'package:get/get.dart';
import 'package:social/features/report/controller/report_overview_controller.dart';
import 'package:social/features/ticket/controller/tickets_controller.dart';
import '../../../../features/profile/view/pages/profile_page.dart';
import '../../../../features/report/view/pages/report_page.dart';
import '../../../../features/share_experience/social/controller/share_experience_controller.dart';
import '../../../../features/share_experience/social/view/pages/share_experience_page.dart';
import '../../../../features/ticket/view/pages/tickets_page.dart';
import '../../../app.dart';
import '../../../app/config/app_setting.dart';
import '../../../app/constants/assets_paths.dart';
import '../../../app/utils/mixin/navigation_mixin.dart';
import '../../notification/controller/notification_controller.dart';
import '../data/models/tab_model.dart';

enum TabName { ticket, report, social, profile }

class AppScaffoldController extends GetxController with StateMixin, NavigationMixin {
  @override
  RxInt index = 0.obs;

  @override
  List<TabModel> tabs = [
    TabModel(
      const TicketsPage(),
      icon: AssetPaths.tickets,
      selectedIcon: AssetPaths.ticketsFill,
      action: TicketsController.to.onInit,
      // title: Messages.tickets,
    ),
    TabModel(
      const ReportPage(),
      icon: AssetPaths.statistics,
      selectedIcon: AssetPaths.statisticsFill,
      action: ReportOverviewController.to.onInit,
      // title: Messages.statistics,
    ),
    TabModel(
      const ShareExperiencePage(),
      icon: AssetPaths.wempo,
      selectedIcon: AssetPaths.wempoFill,
      // title: Messages.wempo,
      action: ShareExperienceController.to.onInit
    ),
    TabModel(
      const ProfilePage(),
      icon: AssetPaths.user,
      selectedIcon: AssetPaths.userFill,
      // title: Messages.user,
    ),
  ];

  bool currentTabIs(TabName tabName) => index.value == tabName.index;

  static AppScaffoldController get to => Get.find<AppScaffoldController>();

  @override
  Future<void> onReady() async {
    App.initDeepLink();

    await NotificationController.showDialogIfHasNotPermission();

    super.onReady();
  }

  setProfileImage(String imageUrl) {
    tabs.removeLast();

    tabs.add(
      TabModel(
        const ProfilePage(),
        profileImage: '${AppSetting.baseUrl}/doctor/file/$imageUrl',
        icon: AssetPaths.user,
        selectedIcon: AssetPaths.userFill,
        // title: Messages.user,
      ),
    );

    update();
  }
}
