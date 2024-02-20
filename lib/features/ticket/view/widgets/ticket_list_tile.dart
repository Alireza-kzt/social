import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/utils/extensions/on_datetime/convertor.dart';
import '../../data/models/ticket_item_model.dart';

class TicketListTile extends StatelessWidget {
  final TicketItemModel ticketModel;
  final void Function(String id)? onTicketPress;

  const TicketListTile({super.key, required this.ticketModel, this.onTicketPress});

  Color statusColor(BuildContext context) {
    if (ticketModel.ticketStatus == TicketStatus.pending) {
      return context.colorScheme.primary;
    } else {
      return context.colorScheme.onBackground;
    }
  }

  String get statusText {
    return switch(ticketModel.ticketStatus) {
      TicketStatus.pending => 'در انتظار پاسخ شما',
      TicketStatus.answered => ticketModel.text,
      TicketStatus.needYourAnswer => 'منتظر پاسخ @user'.trParams({'user' : ticketModel.username}),
      TicketStatus.closed => 'سوال بسته شده است',
      TicketStatus.rejected => 'سوال رد شده است',
      TicketStatus.forceClose => 'مکالمه پایان یافته است',
      TicketStatus.none => '',
      TicketStatus.noPay => '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTicketPress?.call(ticketModel.id),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                ticketModel.username,
                style: context.textTheme.headlineSmall,
              ),
              Text(
                ticketModel.createTime.dateTime.toNowText,
                style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.outline),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                statusText,
                style: context.textTheme.labelLarge?.copyWith(color: statusColor(context)),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
