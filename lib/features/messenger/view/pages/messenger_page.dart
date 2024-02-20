import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';
import '../../../../core/app/view/themes/styles/decorations.dart';
import '../../../ticket/data/models/ticket_item_model.dart';
import '../../controller/messenger_controller.dart';
import '../../controller/messenger_media_controller.dart';
import '../../data/models/user_info_model.dart';
import '../widgets/bubble/message_bubble_widget.dart';
import '../widgets/close_ticket_banner_widget.dart';
import '../widgets/messenger_input.dart';
import '../widgets/user_profile_widget.dart';

class MessengerPage extends StatelessWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupMenuItem _buildPopupMenuItem(String title, Widget icon, TicketStatus status) {
      return PopupMenuItem(
        height: 28,
        value: status,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 4),
            Text(title, style: context.textTheme.labelSmall),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(MessengerController.to.name.value)),
        leading: IconButton(
          icon: SvgPicture.asset(AssetPaths.arrowRight, color: context.colorScheme.outline),
          onPressed: Get.back,
        ),
        actions: [
          MessengerController.to.obx((state) {
            if (MessengerController.to.ticketStatus == TicketStatus.closed ||
                MessengerController.to.ticketStatus == TicketStatus.rejected ||
                MessengerController.to.ticketStatus == TicketStatus.forceClose) {
              return const SizedBox();
            } else {
              return Center(
                child: PopupMenuButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.more_vert_rounded, color: context.colorScheme.outline),
                  offset: const Offset(28, 28),
                  color: context.colorScheme.background,
                  surfaceTintColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  onSelected: MessengerController.to.showCloseDialog,
                  itemBuilder: (ctx) => [
                    _buildPopupMenuItem(
                      'رد کردن تیکت',
                      SvgPicture.asset(
                        AssetPaths.export,
                        color: context.colorScheme.outline,
                        width: 14,
                        height: 14,
                      ),
                      TicketStatus.rejected,
                    ),
                    _buildPopupMenuItem(
                      'پاسخ کامل',
                      SvgPicture.asset(
                        AssetPaths.lock,
                        color: context.colorScheme.error,
                        width: 16,
                        height: 16,
                      ),
                      TicketStatus.closed,
                    ),
                  ],
                ),
              );
            }
          }, onLoading: const SizedBox()),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: MessengerController.to.obx(
                    (messages) => ListView.builder(
                          reverse: true,
                          controller: MessengerController.to.scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: Decorations.paddingHorizontal),
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(bottom: index != 0 ? 16.0 : 0),
                            child: Builder(
                              builder: (_) {
                                final ticketStatus = MessengerController.to.ticketStatus;

                                return Column(
                                  children: [
                                    if (index == messages.length - 1)
                                      UserProfileWidget(
                                        key: MessengerController.to.userProfileKey,
                                        userInfo: MessengerController.to.userInfo,
                                      ),
                                    MessagesBubbleWidget(
                                      message: messages[index],
                                      voiceControllerBuilder: (url) => MessengerController.to.getVoiceController(url!),
                                    ),
                                    if (index == 0)
                                      if (ticketStatus == TicketStatus.closed || ticketStatus == TicketStatus.rejected)
                                        CloseTicketBannerWidget(
                                          ticketStatus: MessengerController.to.ticketStatus,
                                          reason: messages.first.text,
                                        )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                    onLoading: Center(child: LoadingIndicatorWidget(color: context.colorScheme.primary))),
              ),
              MessengerController.to.obx(
                (_) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: MessengerController.to.ticketStatus == TicketStatus.forceClose
                        ? CloseTicketBannerWidget(ticketStatus: MessengerController.to.ticketStatus)
                        : MessengerInput(
                            messageTextEditingController: MessengerController.to.messageTextEditingController,
                            onSendPressed: MessengerController.to.sendMessage,
                            onAttachFileAddPressed: MessengerMediaController.to.onFileButtonPressed,
                            onRecordEnd: MessengerMediaController.to.onVoiceRecorded,
                          ),
                  );
                },
                onLoading: const SizedBox(),
              ),
            ],
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            child: Obx(
              () => AnimatedSize(
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                child: MessengerController.to.userprofileIsVisible.value
                    ? const SizedBox(width: double.infinity)
                    : GestureDetector(
                        onTap: MessengerController.to.scrollToUserProfile,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          color: context.colorScheme.surface,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: context.colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'مشخصات بیمار',
                                style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




