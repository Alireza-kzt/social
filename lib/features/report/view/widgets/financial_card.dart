import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../data/models/ticket_financial_overview_model.dart';

class FinancialCard extends StatelessWidget {
  final TicketFinancialOverviewModel ticketFinancialOverview;

  const FinancialCard({super.key, required this.ticketFinancialOverview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFEFEFEF)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFFF6E7FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${ticketFinancialOverview.datetime.wN} - ${ticketFinancialOverview.datetime.toDateString()}',
                  textAlign: TextAlign.right,
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ticketFinancialOverview.items.length,
            separatorBuilder: (_, index) => const SizedBox(height: 4),
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFFF8F8F8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${ticketFinancialOverview.items[index].title} : ${ticketFinancialOverview.items[index].amount}',
                    style: context.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    ticketFinancialOverview.items[index].income,
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
