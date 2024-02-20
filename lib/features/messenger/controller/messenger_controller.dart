import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/features/messenger/controller/voice_controller.dart';
import 'package:social/features/ticket/data/models/ticket_item_model.dart';
import 'package:taakitecture/taakitecture.dart';
import 'package:uuid/uuid.dart';
import '../../../core/app/utils/mixin/handle_failure_mixin.dart';
import '../../ticket/view/widgets/close_ticket_sheet.dart';
import '../data/models/message_model.dart';
import '../data/models/user_info_model.dart';

class MessengerController extends BaseController with HandleFailureMixin {
  bool initService = true;
  RxString name = ''.obs;
  TicketStatus ticketStatus = TicketStatus.none;
  String ticketId = Get.parameters['id'] ?? Get.arguments;
  Uuid uuid = const Uuid();
  ScrollController scrollController = ScrollController();
  TextEditingController messageTextEditingController = TextEditingController();
  Map<String, VoiceController> voiceControllers = {};
  List<MessagesModel> messages = [];
  List<String> rejectList = [];
  VoiceControllerFlyweight voiceControllerFlyweight = VoiceControllerFlyweight();
  RxBool userprofileIsVisible = true.obs;
  GlobalKey userProfileKey = GlobalKey();
  UserInfoModel userInfo = UserInfoModel();

  MessengerController(super.remoteRepository);

  static MessengerController get to => Get.find();

  @override
  Future<void> onInit() async {
    // await [
    //   Permission.storage,
    //   Permission.microphone,
    //   Permission.audio,
    //   Permission.camera,
    // ].request();

    scrollController.addListener(
      () => userprofileIsVisible.value = scrollController.position.maxScrollExtent - 160 < scrollController.offset,
    );

    getAllMessage();

    super.onInit();
  }

  String generateID() => uuid.v4();

  getAllMessage() => find('/$ticketId');

  sendMessage({String? media, String? message}) async {
    String text = message ?? messageTextEditingController.text;
    text = text.trim();

    if (text.isNotEmpty || media != null) {
      String clientId = generateID();

      MessagesModel newMessage = MessagesModel()
        ..text = text
        ..clientId = clientId
        ..side = MessageSide.doctor
        ..mediaType = MediaType.invalid
        ..time = AppDateTime.now()
        ..media = media;

      messages.add(newMessage);
      super.onSuccess(messages.reversed.toList());
      edit(model: newMessage, params: '$ticketId/respond');
    }

    messageTextEditingController.clear();
  }

  rejectTicket({String? message}) {
    MessagesModel newMessage = MessagesModel()..text = message ?? messageTextEditingController.text;
    edit(model: newMessage, params: '$ticketId/reject');
  }

  closeTicket({String? message}) {
    MessagesModel newMessage = MessagesModel()..text = message ?? messageTextEditingController.text;
    edit(model: newMessage, params: '$ticketId/close');
  }

  @override
  onLoading() {
    if (initService) {
      super.onLoading();
      initService = false;
    }
  }

  @override
  onSuccess(result) {
    name.value = result.name;
    ticketStatus = result.ticketStatus;
    messages = result.messages;
    userInfo = result.userInfo;
    rejectList = result.rejectList;

    super.onSuccess(result.messages.reversed.toList());

    userprofileIsVisible.value = userProfileKey.currentContext != null;
  }

  getVoiceController(String url) => voiceControllerFlyweight.getController(url);

  void showCloseDialog(status) {
    CloseTicketSheet.showDialog(status, rejectList).then(
      (value) {
        if (value != null) {
          if (status == TicketStatus.rejected) {
            rejectTicket(message: value);
          } else {
            closeTicket(message: value);
          }
        }
      },
    );
  }

  Future<void> scrollToUserProfile() async {
    while (userProfileKey.currentContext == null) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }

    Scrollable.ensureVisible(
      userProfileKey.currentContext!,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      alignment: 0.5,
    );
  }
}
