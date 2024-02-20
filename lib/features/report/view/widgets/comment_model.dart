import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../data/models/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;
  final void Function(String chatId)? onTap;

  const CommentWidget({
    super.key,
    required this.commentModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(commentModel.chatId),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  commentModel.author,
                  style: context.textTheme.titleMedium,
                ),
                Text(
                  commentModel.datetime.toString(),
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onInverseSurface),
                ),
              ],
            ),
            const SizedBox(height: 4),
            RatingBarIndicator(
              rating: commentModel.rate.toDouble(),
              itemBuilder: (context, index) => SvgPicture.asset(AssetPaths.star),
              itemCount: 5,
              itemSize: 16.0,
              direction: Axis.horizontal,
            ),
            if (commentModel.text.isNotEmpty) const Divider(height: 24),
            if (commentModel.text.isNotEmpty) Text(commentModel.text, style: context.textTheme.bodyMedium),
            if (!(commentModel.pros.isEmpty && commentModel.cons.isEmpty)) const Divider(height: 24),
            if (!(commentModel.pros.isEmpty && commentModel.cons.isEmpty))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: commentModel.pros.length,
                        separatorBuilder: (_, index) => const SizedBox(height: 8),
                        itemBuilder: (_, index) => Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '+ ',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF028400),
                                ),
                              ),
                              TextSpan(
                                text: commentModel.pros[index],
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: commentModel.cons.length,
                        separatorBuilder: (_, index) => const SizedBox(height: 8),
                        itemBuilder: (_, index) => Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '- ',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFFBA1A1A),
                                ),
                              ),
                              TextSpan(
                                text: commentModel.cons[index],
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
