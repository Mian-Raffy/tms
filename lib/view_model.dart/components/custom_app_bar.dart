import 'package:flutter/material.dart';
import 'package:tms_mobileapp/utils/color_palette.dart';
import 'package:tms_mobileapp/utils/font_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function? onBackTap;
  final bool showBackArrow;
  final Color? backgroundColor;
  final List<Widget>? actionWidgets;

  const CustomAppBar(
      {super.key,
      this.title,
      this.onBackTap,
      this.showBackArrow = true,
      this.backgroundColor = Colors.transparent,
      this.actionWidgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: showBackArrow
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                if (onBackTap != null) {
                  onBackTap!();
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          : null,
      actions: actionWidgets,
      title: Row(
        children: [
          TextButton(
            child: Text(
              title ?? '',
              style: TextStyle(
                color: kBlackColor,
                fontSize: textMedium,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
