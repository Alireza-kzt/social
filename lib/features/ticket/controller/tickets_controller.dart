import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/features/ticket/controller/reject_ticket_controller.dart';

import 'closed_ticket_controller.dart';
import 'open_ticket_controller.dart';

enum TicketsState { open, closed, reject }

class TicketsController extends GetxController {
  late Rx<TicketsState> ticketsState;
  late RxBool isPaginationLoading = false.obs;
  late PageController pageController;

  static TicketsController get to => Get.find();

  openTickets(String id) => Get.toNamed(AppRoutes.chat, arguments: id)?.then((value) => initTickets());

  @override
  void onInit() {
    pageController = PageController();
    ticketsState = TicketsState.open.obs;

    // initTickets();

    // Timer.periodic(const Duration(seconds: 15), (timer) => initTickets());
    super.onInit();
  }

  Future<void> initTickets() async {
    await RejectTicketsController.to.onInit();
    await ClosedTicketsController.to.onInit();
    await OpenTicketsController.to.onInit();
  }

  void onChangeTab(TicketsState state) {
    ticketsState.value = state;
    pageController.animateToPage(state.index, duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }
}
