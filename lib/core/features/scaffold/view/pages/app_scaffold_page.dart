import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/app_scaffold_controller.dart';
import '../widgets/main_bottom_navigation_bar.dart';

class AppScaffoldPage extends StatelessWidget {
  const AppScaffoldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppScaffoldController.to.obx((tab) => tab),
      bottomNavigationBar: GetBuilder<AppScaffoldController>(
        builder: (_) {
          return MainBottomNavigationBar(
            tabs: AppScaffoldController.to.tabs,
            onIndexChanged: AppScaffoldController.to.setIndex,
            selectedIndex: AppScaffoldController.to.index.value,
          );
        },
      ),
    );
  }
}
