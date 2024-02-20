import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/features/ticket/data/models/ticket_item_model.dart';

class CloseTicketBannerWidget extends StatelessWidget {
  final TicketStatus ticketStatus;
  final String? reason;

  const CloseTicketBannerWidget({super.key, required this.ticketStatus, this.reason});

  String get title {
    if (ticketStatus == TicketStatus.rejected) {
      return "این تیکت رد شد";
    } else {
      return "این تیکت بسته شد";
    }
  }

  Widget get icon {
    if (ticketStatus == TicketStatus.closed) {
      return SvgPicture.asset(AssetPaths.closeTicket);
    } else {
      return SvgPicture.asset(AssetPaths.export);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: context.colorScheme.error.withOpacity(0.08),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: context.colorScheme.error)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 4),
              Text(title, style: context.textTheme.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}
