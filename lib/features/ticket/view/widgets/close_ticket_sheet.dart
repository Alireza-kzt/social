import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/widgets/check_box/check_radio_widget.dart';
import 'package:social/core/app/view/widgets/input/input.dart';
import '../../../../core/app/constants/messages.dart';
import '../../../../core/app/view/themes/styles/buttons/button_types.dart';
import '../../data/models/ticket_item_model.dart';

class CloseTicketSheet extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  final TicketStatus status;
  final RxInt selectedTextIndex = double.maxFinite.toInt().obs;
  final List<String>? rejectList;

  CloseTicketSheet({Key? key, required this.status, this.rejectList}) : super(key: key);

  static Future showDialog(TicketStatus status, List<String>? rejectList) => Get.bottomSheet(
        CloseTicketSheet(
          status: status,
          rejectList: rejectList,
        ),
        isScrollControlled: true,
        enableDrag: false,
        elevation: 0,
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: Get.back,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: context.height,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(status == TicketStatus.rejected ? AssetPaths.export : AssetPaths.lock, height: 32, width: 32),
                      const SizedBox(height: 8),
                      Text(status == TicketStatus.rejected ? 'رد تیکت' : 'پاسخ کامل', style: context.textTheme.headlineSmall),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            status == TicketStatus.rejected
                                ? 'با انتخاب این گزینه، تیکت رد و اعتبار به حساب کاربر برمی‌گرده'
                                : 'با انتخاب پاسخ کامل، تیکت بسته خواهد شد',
                            style: context.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 4),
                          if (status == TicketStatus.rejected)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Obx(() => Column(
                                    children: [
                                      Row(
                                        children: [
                                          for (int i = 0; i < rejectList!.length; i++)
                                            RejectTextRadioWidget(
                                              padding: EdgeInsets.only(left: i.isEven ? 16 : 0),
                                              text: rejectList![i],
                                              isSelected: selectedTextIndex.value == i,
                                              onTap: () {
                                                textEditingController.text = rejectList![i];
                                                selectedTextIndex.value = i;
                                              },
                                            ),
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          if (status == TicketStatus.rejected)
                            Input(
                              hintText: 'دلیل رد کردن تیکت را بنویسید',
                              controller: textEditingController,
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          TextButton(
                            onPressed: Get.back,
                            style: context.buttonThemes.textButtonStyle(color: ButtonColors.surface, size: ButtonSizes.small),
                            child: Text(Messages.cancel),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () => Get.back(result: textEditingController.text),
                            style: context.buttonThemes.textButtonStyle(color: ButtonColors.primary, size: ButtonSizes.small),
                            child: Text(status == TicketStatus.rejected ? 'رد تیکت' : 'پاسخ کامل'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RejectTextRadioWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  const RejectTextRadioWidget({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: FittedBox(
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                CheckRadioWidget(isSelected: isSelected),
                const SizedBox(width: 4),
                Text(
                  text,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
